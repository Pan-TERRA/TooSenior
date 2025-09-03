import Foundation

public actor PluginComposer {
    private let plugins: [NetworkPlugin]
    
    public init(plugins: [NetworkPlugin]) {
        self.plugins = plugins
    }
    
    public func processRequest(_ request: inout URLRequest) async throws {
        for plugin in plugins {
            try await plugin.processRequest(&request)
        }
    }
    
    public func processResponse(_ response: HTTPURLResponse, data: Data, originalRequest: URLRequest) async throws {
        for plugin in plugins {
            try await plugin.processResponse(response, data: data, originalRequest: originalRequest)
        }
    }
    
    public func processError(_ error: Error, request: URLRequest) async -> Error {
        var processedError = error
        for plugin in plugins {
            processedError = await plugin.processError(processedError, request: request)
        }
        return processedError
    }
}