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
        configure()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        configureView()
        configureLabel()
    }

    // MARK: - flow funcs
    func configure() {
        configureView()
        configureImageView()
        configureLabel()
    }

    func configureView() {
        containerView.rounded()
        containerView.layer.masksToBounds = true
        containerView.backgroundColor = isSelected ? .specialPink : .specialGray
    }

    func configureImageView() {
        ingredientImage.rounded()
    }

    func configureLabel() {
        ingredientLabel.font = .poppinsBold16()
        ingredientLabel.textColor = .specialBlack
        quantityLabel.font = .poppinsRegular14()
        quantityLabel.textColor = isSelected ? .white : .specialLightGray
    }
}
