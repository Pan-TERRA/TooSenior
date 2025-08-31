import Foundation

public final class NetworkClientFactory {
    private static let mainAPIBaseURL = "https://api.ourapp.com"
    
    public static func mainAPI() -> NetworkClient {
        NetworkClient(
            configuration: NetworkConfiguration.mainAPI(baseURL: mainAPIBaseURL),
            tokenInteractor: DefaultTokenRefreshInteractor(),
            plugins: [LoggerPlugin()],
            session: .shared
        )
    }
}
