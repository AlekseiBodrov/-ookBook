import UIKit

class IngredientHeaderView: UITableViewHeaderFooterView {
    // MARK: - property
    @IBOutlet weak var ingredientsHeaderLabel: UILabel!
    @IBOutlet weak var countOfIngredientsLabel: UILabel!

    // MARK: - life cycle funcs
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }

    // MARK: - flow funcs
    func configure() {
        cofigureLabel()
    }

    func cofigureLabel() {
        ingredientsHeaderLabel.font = .poppinsBold20()
        ingredientsHeaderLabel.textColor = .specialBlack
        countOfIngredientsLabel.font = .poppinsRegular14()
        countOfIngredientsLabel.textColor = .specialLightGray
    }
}
