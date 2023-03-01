import UIKit

struct Ingredients {
    var ingredientName: String
    var quantity: String
}

class RecipeViewController: UIViewController {
    // MARK: - constant
    private let headerHeight: CGFloat = 44

    // MARK: - property
    private let makeLabel = UILabel()
    private let recipeImageView = UIImageView()
    private var ingredientTableView = UITableView()

    var ingredients: [Ingredients] = [
        Ingredients(ingredientName: "Apples", quantity: "4-5qty"),
        Ingredients(ingredientName: "Flower", quantity: "150g"),
        Ingredients(ingredientName: "Eggs", quantity: "4qty"),
        Ingredients(ingredientName: "Shugar", quantity: "200g"),
        Ingredients(ingredientName: "Vanila sugar", quantity: "1sp"),
        Ingredients(ingredientName: "Cinnamon", quantity: "2sp"),
        Ingredients(ingredientName: "Baking powder", quantity: "0,5sp"),
        Ingredients(ingredientName: "Lemon juice", quantity: "0,5ps"),
        Ingredients(ingredientName: "Sugar powder", quantity: "2sp"),
    ]
    // MARK: - life cycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubViews()
        configure()
        setConstraints()
    }

    // MARK: - flow funcs
    private func addSubViews() {
        view.addSubview(makeLabel)
        view.addSubview(recipeImageView)
        view.addSubview(ingredientTableView)
    }

    private func configure() {
        configureLabel()
        configureImageView()
        configureTableView()
        configureNavigationBar()
        setConstraints()
    }

    private func configureLabel() {
        makeLabel.translatesAutoresizingMaskIntoConstraints = false
        makeLabel.text = "How to make french toast"
        makeLabel.textColor = .black
        makeLabel.font = UIFont.boldSystemFont(ofSize: 28)
        makeLabel.textAlignment = .left
        makeLabel.numberOfLines = 0
    }

    private func configureImageView() {
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false
        recipeImageView.layer.masksToBounds = true
        recipeImageView.image = UIImage(named: "recipeImage")
        recipeImageView.contentMode = .scaleAspectFill
        recipeImageView.layer.cornerRadius = 12
    }

    private func configureNavigationBar() {
        let backButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: RecipeViewController.self, action: #selector(backButtonAction))
        navigationItem.leftBarButtonItem = backButtonItem
    }

    private func configureTableView() {
        ingredientTableView.translatesAutoresizingMaskIntoConstraints = false
        ingredientTableView.delegate = self
        ingredientTableView.dataSource = self
        ingredientTableView.separatorStyle = .none
        ingredientTableView.register(UINib(nibName: "IngredientTableViewCell", bundle: nil), forCellReuseIdentifier: "IngredientTableViewCell")
        ingredientTableView.register(UINib(nibName: "IngredientHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "IngredientHeaderView")
        ingredientTableView.allowsMultipleSelection = true
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            makeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            makeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            makeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            recipeImageView.topAnchor.constraint(equalTo: makeLabel.bottomAnchor, constant: 24),
            recipeImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            recipeImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            recipeImageView.heightAnchor.constraint(equalToConstant: 200),

            ingredientTableView.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: 24),
            ingredientTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            ingredientTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ingredientTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    @objc func backButtonAction() {
        print("back")
    }
}

// MARK: - extension Delegate
extension RecipeViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ingredients.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientTableViewCell", for: indexPath) as! IngredientTableViewCell
        let item = ingredients[indexPath.row]
        cell.ingredientLabel.text = item.ingredientName
        cell.quantityLabel.text = item.quantity
        return cell
    }

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "IngredientHeaderView") as! IngredientHeaderView
        return header
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight
    }
}
