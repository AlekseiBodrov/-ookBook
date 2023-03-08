import UIKit

class CategoryListViewController: UIViewController {
    // MARK: - property
    private let tableView = UITableView()
    private var categories = [
        "Breakfast",
        "Deserts",
        "Soups",
        "Starters",
        "Appetizers",
        "Salads",
        "Fish",
        "Lamb",
        "Vegetarian",
        "Bakery"
    ]

    // MARK: - life cycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        configure()
    }

    // MARK: - flow funcs
    private func addSubViews() {
        view.addSubview(tableView)
        view.backgroundColor = .white
    }

    private func configure() {
        configureTableView()
        setConstraints()
    }

    private func configureTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        tableView.register(UINib(nibName: "HeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "HeaderView")
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }}

// MARK: - extension Delegate
extension CategoryListViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.selectionStyle = .none
        let item = categories[indexPath.row]
        cell.categoryNameLabel.text = item
        return cell
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CategoryViewController()
        present(vc, animated: true)
    }
}
