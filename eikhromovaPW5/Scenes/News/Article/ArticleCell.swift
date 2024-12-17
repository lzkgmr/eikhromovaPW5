import UIKit

// MARK: - ArticleCell
final class ArticleCell: UITableViewCell {
    
    // MARK: - Constants
    internal enum Constants {
        static let reuseId: String = "ArticleCell"
        static let cornerRadius: CGFloat = 5
        static let titleFontSize: CGFloat = 14
        static let titleTextColor: UIColor = .systemPink
        static let titleNumberOfLines: Int = 2
        static let descriptionFontSize: CGFloat = 11
        static let descriptionTextColor: UIColor = .black
        static let descriptionNumberOfLines: Int = 2
        static let imageHorizontal: CGFloat = 20
        static let imageHeight: Double = 200
        static let imageWidth: Double = 310
        static let titleTop: CGFloat = 5
        static let titleHorizontal: CGFloat = 10
        static let descriptionTop: CGFloat = 3
        static let descriptionHorizontal: CGFloat = 10
        static let error: String = "init(coder:) has not been implemented"
        
    }
    
    // MARK: - Fields
    private let articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constants.cornerRadius
        return imageView
    }()
    
    private let articleTitleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = Constants.titleNumberOfLines
        titleLabel.font = .boldSystemFont(ofSize: Constants.titleFontSize)
        titleLabel.textColor = Constants.titleTextColor
        return titleLabel
    }()
    
    private let articleDescriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.numberOfLines = Constants.descriptionNumberOfLines
        descriptionLabel.font = .systemFont(ofSize: Constants.descriptionFontSize)
        descriptionLabel.textColor = Constants.descriptionTextColor
        return descriptionLabel
    }()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.error)
    }
    
    // MARK: - UI Configuration
    private func configureUI() {
        configureImageView()
        configureTitleLabel()
        configureDescriptionLabel()
    }
    
    // MARK: - Image View Configuration
    private func configureImageView() {
        contentView.addSubview(articleImageView)
        articleImageView.pinCenterY(to: contentView)
        articleImageView.pinHorizontal(to: contentView, Constants.imageHorizontal)
        articleImageView.setHeight(Constants.imageHeight)
        articleImageView.setWidth(Constants.imageWidth)
    }
    
    // MARK: - Title Label Configuration
    private func configureTitleLabel() {
        contentView.addSubview(articleTitleLabel)
        articleTitleLabel.pinTop(to: articleImageView.bottomAnchor, Constants.titleTop)
        articleTitleLabel.pinHorizontal(to: articleImageView, Constants.titleHorizontal)
    }
    
    // MARK: - Description Configuration
    private func configureDescriptionLabel() {
        contentView.addSubview(articleDescriptionLabel)
        articleDescriptionLabel.pinTop(to: articleTitleLabel.bottomAnchor, Constants.descriptionTop)
        articleDescriptionLabel.pinHorizontal(to: articleImageView, Constants.descriptionHorizontal)
    }
    
    // MARK: - Image Loading
    private func loadImage(from imageURL: URL) {
        DispatchQueue.global().async { [weak self] in
            guard let data = try? Data(contentsOf: imageURL) else {return}
            guard let image = UIImage(data: data) else {return}
            
            DispatchQueue.main.async {
                self?.articleImageView.image = image
            }
        }
    }
    
    // MARK: - Article Configuration
    func configure(with article: Models.Article) {
        articleTitleLabel.text = article.title
        articleDescriptionLabel.text = article.announce
        if let url = article.img?.url {
            loadImage(from: url)
        }
    }
}
