import Foundation

public actor NetworkClient {
    private let configuration: NetworkConfiguration
    private let session: URLSession
    private let pluginComposer: PluginComposer
    private let tokenInteractor: TokenRefreshInteractorProtocol
    private let tokenStore: SecureTokenStoreProtocol
    
    init(
        configuration: NetworkConfiguration,
        tokenStore: SecureTokenStoreProtocol,
        tokenInteractor: TokenRefreshInteractorProtocol,
        plugins: [NetworkPlugin],
        session: URLSession
    ) {
        self.configuration = configuration
        self.tokenStore = tokenStore
        self.session = session
        self.pluginComposer = PluginComposer(plugins: plugins)
        self.tokenInteractor = tokenInteractor
    }
    
    public func perform<T>(
        request: HTTPRequest,
        serializer: any ResponseSerializer<T>
    ) async throws -> ApiResponse<T> {
        do {
            let urlRequest = try await buildRequestWithPlugins(request)
            return try await executeRequest(urlRequest, serializer: serializer)
        } catch NetworkError.unauthorized {
            if await tokenInteractor.attemptTokenRefresh() {
                do {
                    let retryRequest = try await buildRequestWithPlugins(request)
                    return try await executeRequest(retryRequest, serializer: serializer)
                } catch {
                    // Even retry failed - let plugins process the final error
                    let originalRequest = try? request.urlRequest(
                        baseURL: configuration.baseURL, 
                        defaultHeaders: configuration.defaultHeaders
                    )
                    let processedError = await pluginComposer.processError(error, request: originalRequest ?? URLRequest(url: URL(string: "unknown")!))
                    throw processedError
                }
            } else {
                await tokenInteractor.clearTokens()
                let authError = NetworkError.authenticationRequired
                let originalRequest = try? request.urlRequest(
                    baseURL: configuration.baseURL, 
                    defaultHeaders: configuration.defaultHeaders
                )
                let processedError = await pluginComposer.processError(authError, request: originalRequest ?? URLRequest(url: URL(string: "unknown")!))
                throw processedError
            }
        } catch {
            let originalRequest = try? request.urlRequest(
                baseURL: configuration.baseURL, 
                defaultHeaders: configuration.defaultHeaders
            )
            let processedError = await pluginComposer.processError(error, request: originalRequest ?? URLRequest(url: URL(string: "unknown")!))
            throw processedError
        }
    }
    
    private func buildRequestWithPlugins(_ httpRequest: HTTPRequest) async throws -> URLRequest {
        var urlRequest = try httpRequest.urlRequest(
            baseURL: configuration.baseURL,
            defaultHeaders: configuration.defaultHeaders
        )
        
        if let authHeader = await resolveAuthorization(httpRequest.authorization) {
            urlRequest.setValue(authHeader, forHTTPHeaderField: "Authorization")
        }
        
        try await pluginComposer.processRequest(&urlRequest)
        return urlRequest
    }
    
    private func resolveAuthorization(_ authorization: Authorization) async -> String? {
        switch authorization {
        case .currentUser:
            return await tokenStore.getAuthorizationHeader()
        case .none:
            return nil
        }
    }
    
    private func executeRequest<T>(
        _ urlRequest: URLRequest,
        serializer: any ResponseSerializer<T>
    ) async throws -> ApiResponse<T> {
        do {
            let (data, response) = try await session.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                let error = NetworkError.invalidResponse
                let processedError = await pluginComposer.processError(error, request: urlRequest)
                throw processedError
            }
            
            let apiResponse = ApiResponse(
                value: data,
                httpResponse: httpResponse,
                request: urlRequest
            )
            
            try await pluginComposer.processResponse(httpResponse, data: data, originalRequest: urlRequest)
            
            if apiResponse.isUnauthorized() {
                let error = NetworkError.unauthorized
                let processedError = await pluginComposer.processError(error, request: urlRequest)
                throw processedError
            }
            
            if httpResponse.statusCode >= 400 {
                let error = NetworkError.httpError(statusCode: httpResponse.statusCode)
                let processedError = await pluginComposer.processError(error, request: urlRequest)
                throw processedError
            }
            
            let serializedValue = try serializer.serialize(data, response: httpResponse)
            return ApiResponse(
                value: serializedValue,
                httpResponse: httpResponse,
                request: urlRequest
            )
            
        } catch {
            // Handle unexpected errors (network, serialization, etc.)
            let processedError = await pluginComposer.processError(error, request: urlRequest)
            throw processedError
        }
    }
}
