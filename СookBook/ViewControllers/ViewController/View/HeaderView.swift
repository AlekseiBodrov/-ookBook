import UIKit

class HeaderView: UITableViewHeaderFooterView {
    // MARK: - property
    @IBOutlet weak var headerLabel: UILabel!
    // MARK: - life cycle funcs
    override func awakeFromNib() {
        super.awakeFromNib()
        configureLabel()
    }
    // MARK: - flow funcs
    func configureLabel() {
        headerLabel.text = "Category"
    }
}
