import UIKit

// MARK: -NewsViewController
final class NewsViewController: UIViewController {
    
    // MARK: - Constants
    private enum Constants {
        static let heighForRowAt: CGFloat = 280
        static let backgroundColor: UIColor = .white
        static let error: String = "init(coder:) has not been implemented"
    }
    
    // MARK: - Fields
    var tableView: UITableView = UITableView()
    private var interactor: (BusinessLogic & DataStore)?
    let refreshControl = UIRefreshControl()
    
    // MARK: - Lifecycle
    init(interactor: (BusinessLogic & DataStore)?) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.error)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        configurateTableView()
        interactor?.loadFreshNews()
    }
    
    // MARK: - TableView Configuration
    private func configurateTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ArticleCell.self, forCellReuseIdentifier: ArticleCell.Constants.reuseId)
        
        tableView.backgroundColor = Constants.backgroundColor
        tableView.separatorColor = UIColor.clear
        tableView.refreshControl = refreshControl
        
        tableView.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        tableView.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor)
        tableView.pinLeft(to: view.leadingAnchor)
        tableView.pinRight(to: view.trailingAnchor)
        
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    // MARK: - Actions
    @objc
    private func refreshData() {
        interactor?.loadFreshNews()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.heighForRowAt
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let articleURL = interactor?.articles[indexPath.row].articleUrl
        interactor?.routeToWebNews(
            Models.Request(
                articleURL: articleURL)
        )
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor?.articles.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleCell.Constants.reuseId, for: indexPath) as? ArticleCell else {
            return UITableViewCell()
        }
        if let article = interactor?.articles[indexPath.row] {
            cell.backgroundColor = .white
            cell.selectionStyle = .none
            cell.configure(with: article)
        }
        return cell
    }
}
