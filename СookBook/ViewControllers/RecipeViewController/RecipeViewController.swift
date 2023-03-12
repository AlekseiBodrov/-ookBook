import UIKit

struct Ingredients{
    var ingredientName: String
    var quantity: String
    var unit: String
}

final class RecipeViewController: UIViewController {
    // MARK: - constant
    private let headerHeight: CGFloat = 44
<<<<<<< HEAD
    
    let recipeID: Int = 1  //в дальнейшем нужно конфигурировать данный VC по этотму id(для него нужен свой init, далее этот id мы передаем при вызове рецепта  present(StepViewController(id: recipeID), animated: true))

=======
    let networkManager = NetworkManager()
    var recipeId = 0
>>>>>>> develop
    // MARK: - property
    let makeLabel = UILabel()
    let recipeImageView = UIImageView()
    private var ingredientTableView = UITableView()
    private var instructionsButton = UIButton()
    private var ingredients: [RecipeData.Ingredients] = []
    
    // MARK: - life cycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        configure()
        networkManager.searchRecipeById(by: recipeId) { [unowned self] data in
            DispatchQueue.main.async {
                self.ingredients.append(contentsOf: data.extendedIngredients)
                self.ingredientTableView.reloadData()
                print(self.ingredients)
            }
        }
    }

    // MARK: - flow funcs
    private func addSubViews() {
        view.addSubview(makeLabel)
        view.addSubview(recipeImageView)
        view.addSubview(ingredientTableView)
        view.addSubview(instructionsButton)
    }

    private func configure() {
        configureView()
        configureLabel()
        configureImageView()
        configureTableView()
        configureButton()
        configureNavigationBar()
        setConstraints()
    }

    private func configureView() {
        view.backgroundColor = .white
    }

    private func configureLabel() {
        makeLabel.translatesAutoresizingMaskIntoConstraints = false
        makeLabel.textColor = .specialBlack
        makeLabel.font = .poppinsBold24()
        makeLabel.textAlignment = .left
        makeLabel.numberOfLines = 0
    }

    private func configureImageView() {
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false
        recipeImageView.layer.masksToBounds = true
        recipeImageView.contentMode = .scaleAspectFill
        recipeImageView.rounded()
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

    private func configureButton() {
        instructionsButton.translatesAutoresizingMaskIntoConstraints = false
        instructionsButton.setTitle("Preparations steps", for: .normal)
        instructionsButton.backgroundColor = .specialRed
        instructionsButton.titleLabel?.font = .poppinsBold16()
        instructionsButton.rounded()
        instructionsButton.addTarget(self, action: #selector(instructionButtonAction), for: .touchUpInside)
    }

    
    private func configureNavigationBar() {
        let backButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: RecipeViewController.self, action: #selector(backButtonAction))
        navigationItem.leftBarButtonItem = backButtonItem
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

            instructionsButton.topAnchor.constraint(equalTo: ingredientTableView.bottomAnchor, constant: 8),
            instructionsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            instructionsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            instructionsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            instructionsButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }

    @objc func backButtonAction() {
       //
    }

    @objc func instructionButtonAction() {
        let vc = StepViewController(id: recipeId)
        present(vc, animated: true)
        print("Open Preparations Steps")
    }
}
// MARK: - extension Delegate
extension RecipeViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientTableViewCell", for: indexPath) as! IngredientTableViewCell
        cell.selectionStyle = .none
        let item = ingredients[indexPath.row]
        cell.ingredientLabel.text = item.name
        cell.quantityLabel.text = "\(item.amount) \(item.unit ?? "")"
        cell.ingredientImage.image = UIImage(named: "ingredients")
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
