import Foundation

public actor NetworkClient {
    private let configuration: NetworkConfiguration
    private let session: URLSession
    private let pluginComposer: PluginComposer
    private let tokenInteractor: TokenRefreshInteractorProtocol
    
    init(
        configuration: NetworkConfiguration,
        tokenInteractor: TokenRefreshInteractorProtocol,
        plugins: [NetworkPlugin],
        session: URLSession
    ) {
        self.configuration = configuration
        self.session = session
        self.pluginComposer = PluginComposer(plugins: plugins)
        self.tokenInteractor = tokenInteractor
    }
    
    public func perform<T>(
        request: HTTPRequest,
        serializer: ResponseSerializer<T>
    ) async throws -> ApiResponse<T> {
        let urlRequest = try await buildRequestWithPlugins(request)
        
        do {
            return try await executeRequest(urlRequest, serializer: serializer)
        } catch NetworkError.unauthorized {
            let refreshed = await tokenInteractor.attemptTokenRefresh()
            if refreshed {
                let retryRequest = try await buildRequestWithPlugins(request)
                return try await executeRequest(retryRequest, serializer: serializer)
            } else {
                await tokenInteractor.clearTokens()
                throw NetworkError.authenticationRequired
            }
        }
    }
    
    private func buildRequestWithPlugins(_ httpRequest: HTTPRequest) async throws -> URLRequest {
        var urlRequest = try httpRequest.urlRequest(
            baseURL: configuration.baseURL,
            defaultHeaders: configuration.defaultHeaders
        )
        try await pluginComposer.processRequest(&urlRequest)
        return urlRequest
    }
    
    private func executeRequest<T>(
        _ urlRequest: URLRequest,
        serializer: ResponseSerializer<T>
    ) async throws -> ApiResponse<T> {
        let (data, response) = try await session.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        let apiResponse = ApiResponse(
            value: data,
            httpResponse: httpResponse,
            request: urlRequest
        )
        
        try await pluginComposer.processResponse(httpResponse, data: data, originalRequest: urlRequest)
        
        if apiResponse.isUnauthorized() {
            throw NetworkError.unauthorized
        }
        
        if httpResponse.statusCode >= 400 {
            throw NetworkError.httpError(statusCode: httpResponse.statusCode)
        }
        
        let serializedValue = try serializer.serialize(data, response: httpResponse)
        return ApiResponse(
            value: serializedValue,
            httpResponse: httpResponse,
            request: urlRequest
        )
    }
}