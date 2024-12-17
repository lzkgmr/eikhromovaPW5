import UIKit

// MARK: - News Assembly
enum Assembly {
    static func build() -> UIViewController {
        let presenter = Presenter()
        let interactor = Interactor(presenter: presenter)
        let view = NewsViewController(interactor: interactor)
        presenter.view = view
        
        return view
    }
}
