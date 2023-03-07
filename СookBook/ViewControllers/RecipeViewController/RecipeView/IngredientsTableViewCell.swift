import UIKit

class IngredientTableViewCell: UITableViewCell {

    // MARK: - property
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var ingredientImage: UIImageView!
    @IBOutlet weak var ingredientLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!

    // MARK: - life cycle funcs
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
        configureImageView()
    }
    // MARK: - flow funcs
    func configureView() {
        containerView.layer.cornerRadius = 12
        containerView.layer.masksToBounds = true
    }

    func configureImageView() {
        ingredientImage.layer.cornerRadius = 12
    }
}
