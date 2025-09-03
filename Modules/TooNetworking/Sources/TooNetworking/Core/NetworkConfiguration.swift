import Foundation

struct NetworkConfiguration {
    let baseURL: String
    let defaultHeaders: [String: String]
    
    private init(
        baseURL: String,
        defaultHeaders: [String: String]
    ) {
        self.baseURL = baseURL
        self.defaultHeaders = defaultHeaders
    }
    
    static func mainAPI(baseURL: String) -> NetworkConfiguration {
        NetworkConfiguration(baseURL: baseURL, defaultHeaders: [:])
    }
}
