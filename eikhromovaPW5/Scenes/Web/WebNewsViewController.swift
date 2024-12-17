import UIKit
import WebKit

// MARK: - WebNewsViewController
final class WebNewsViewController: UIViewController {
    
    // MARK: - Variables
    private var interactor: WebBusinessLogic
    var url: URL?
    var webView: WKWebView = WKWebView()
    
    // MARK: - Lifecycle
    init(interactor: WebBusinessLogic, url: URL?) {
        self.interactor = interactor
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureWebView()
        webView.load(URLRequest(url: url!))
    }
    
    // MARK: - Web View Configuration
    private func configureWebView() {
        view.addSubview(webView)
        webView.pinHorizontal(to: view)
        webView.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        webView.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor)
    }
}
