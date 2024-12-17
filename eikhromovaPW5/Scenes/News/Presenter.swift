import UIKit

// MARK: - News Presentor
final class Presenter: PresentationLogic {
    weak var view: NewsViewController?
    
    func presentNews() {
        DispatchQueue.main.async {
            self.view?.tableView.reloadData()
            self.view?.refreshControl.endRefreshing()
        }
    }
    
    func routeToWebNews(_ response: Models.Response) {
        view?.navigationController?.pushViewController(
            WebAssembly.build(with: response.articleURL),
            animated: true)
    }
}
