import Foundation

public final class NetworkClientFactory {
    private static let mainAPIBaseURL = "https://api.ourapp.com"
    
    public static func mainAPI(tokenInteractor: TokenRefreshInteractorProtocol) -> NetworkClient {
        NetworkClient(
            configuration: NetworkConfiguration.mainAPI(baseURL: mainAPIBaseURL),
            tokenInteractor: tokenInteractor,
            plugins: [LoggerPlugin()],
            session: .shared
        )
    }
}
