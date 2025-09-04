import Foundation

public final class NetworkClientFactory {
    private static let infiniteFeedAPIBaseURL = "https://infinite-feed-sample.vercel.app"
    
    public static func infiniteFeedAPI() -> NetworkClient {
        NetworkClient(
            configuration: NetworkConfiguration.mainAPI(baseURL: infiniteFeedAPIBaseURL),
            tokenStore: SecureTokenStore.shared,
            tokenInteractor: DefaultTokenRefreshInteractor(),
            plugins: [LoggerPlugin()],
            session: .shared
        )
    }
}
