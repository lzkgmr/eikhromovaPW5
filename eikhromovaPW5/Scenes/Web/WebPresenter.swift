import UIKit

// MARK: - Web Presenter
final class WebPresenter: WebPresentationLogic {
    weak var view: WebNewsViewController?

    func routeToNews() {
        view?.navigationController?.popViewController(animated: true)
    }
}
