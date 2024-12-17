import UIKit

// MARK: - News Protocols
protocol BusinessLogic {
    func loadFreshNews()
    func loadMoreNews()
    func routeToWebNews(_ request: Models.Request)
}
protocol DataStore {
    var articles: [Models.Article] {get set}
}

protocol PresentationLogic {
    func presentNews()
    func routeToWebNews(_ response: Models.Response)
}
