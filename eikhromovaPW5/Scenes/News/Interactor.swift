import UIKit

// MARK: - News Interactor
final class Interactor: BusinessLogic, DataStore {
    private var presenter: PresentationLogic
    private var manager = ArticleManager()
    var articles: [Models.Article] = [] {
        didSet {
            presenter.presentNews()
        }
    }
    
    init(presenter: PresentationLogic) {
        self.presenter = presenter
    }
    
    func loadFreshNews() {
        manager.parseNews { [weak self] news in
            self?.articles = news
        }
    }
    
    func loadMoreNews() {
        manager.parseNews { [weak self] news in
            self?.articles += news
        }
    }
    
    func routeToWebNews(_ request: Models.Request) {
        presenter.routeToWebNews(
            Models.Response(
                articleURL: request.articleURL)
        )
    }
}
