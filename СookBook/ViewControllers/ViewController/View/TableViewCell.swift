import UIKit

class TableViewCell: UITableViewCell {

    // MARK: - property
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var categoryNameLabel: UILabel!

    // MARK: - life cycle funcs
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }

    // MARK: - flow funcs
    private func configure() {
        configureLabel()
    }

    private func configureLabel() {
        categoryNameLabel.text = "Category name"
    }
}
