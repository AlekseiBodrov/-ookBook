import UIKit

class CategoryListTableViewCell: UITableViewCell {
    // MARK: - constant
    private let shadowAlpha = 0.36
    
    // MARK: - property
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var categoryNameLabel: UILabel!

    // MARK: - life cycle funcs
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }

    // MARK: - flow funcs
    private func configure() {
        configureImageView()
        configureView()
        configureLabel()
    }

    private func configureImageView() {
        categoryImageView.rounded()
    }

    private func configureView() {
        shadowView.rounded()
        shadowView.backgroundColor = .specialBlack
        shadowView.alpha = shadowAlpha
    }

    private func configureLabel() {
        categoryNameLabel.text = "Category"
        categoryNameLabel.textColor = .white
        categoryNameLabel.font = .poppinsBold24()
    }
}
