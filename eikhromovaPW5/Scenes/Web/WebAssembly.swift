import UIKit

// MARK: - Web Assembly
enum WebAssembly {
    static func build(with url: URL?) -> UIViewController {
        let presenter = WebPresenter()
        let interactor = WebInteractor(presenter: presenter)
        let view = WebNewsViewController(interactor: interactor, url: url)
        presenter.view = view
        return view
    }
}
