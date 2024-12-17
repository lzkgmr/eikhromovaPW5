import UIKit

// MARK: - Article Manager
final class ArticleManager {
    
    // MARK: - Constants
    private enum Constants {
        static let rubric: Int = 4
        static let page: Int = 1
    }
    
    // MARK: - Fields
    private let decoder: JSONDecoder = JSONDecoder()
    private var newsPage: Models.NewsPage = Models.NewsPage()
    
    // MARK: - News JSON Parsing
    func parseNews(completion: @escaping ([Models.Article]) -> Void) {
        guard let url = getURL(Constants.rubric, Constants.page) else { return }
        URLSession.shared.dataTask(with: url) {[weak decoder] data, response, error in
            if let error = error {
                print(error)
                return
            }
            if
                let data = data, let decoder,
                var newsPage = try? decoder.decode(Models.NewsPage.self, from: data)
            {
                newsPage.passTheRequestId()
                DispatchQueue.main.async {
                    completion(newsPage.news ?? [])
                }
            }
        }.resume()
    }
    
    // MARK: - URL Getting
    private func getURL(_ rubric: Int, _ pageIndex: Int) -> URL? {
        URL(string: "https://news.myseldon.com/api/Section?rubricId=\(rubric)&pageSize=8&pageIndex=\(pageIndex)")
    }
}
