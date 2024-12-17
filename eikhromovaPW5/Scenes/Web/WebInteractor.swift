import UIKit

// MARK: - Web Interactor
final class WebInteractor: WebBusinessLogic {
    private var presenter: WebPresentationLogic

    init(presenter: WebPresentationLogic) {
        self.presenter = presenter
    }

    func routeToNews() {
        presenter.routeToNews()
    }
}
