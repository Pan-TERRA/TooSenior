import Foundation

public final class NetworkClientFactory {
    private static let mainAPIBaseURL = "https://api.ourapp.com"
    
    public static func mainAPI() -> NetworkClient {
        NetworkClient(
            configuration: NetworkConfiguration.mainAPI(baseURL: mainAPIBaseURL),
            tokenStore: SecureTokenStore.shared,
            tokenInteractor: DefaultTokenRefreshInteractor(),
            plugins: [LoggerPlugin()],
            session: .shared
        )
    }
}
