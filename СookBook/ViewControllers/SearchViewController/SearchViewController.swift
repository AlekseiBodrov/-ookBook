//
//  SearchViewController.swift
//  СookBook
//
//  Created by Admin on 11.03.23.
//

import UIKit

class SearchViewController: UIViewController {

    // MARK: - constants
    enum Constants {
        static let searchTextFieldLabel: String = "Search recepies"
        static let bookmarkImage: String = "heart"
        static let searchImage: String = "search"
        static let tabBarImage: String = "house.fill"
        static let topViewSideSpacing: CGFloat = 20.0
        static let searchTFHeight: CGFloat = 44.0
        static let topViewHeight: CGFloat = 44.0
        static let tableViewTopSpacing: CGFloat = 20.0
        static let heightForRow: CGFloat = 104.0
        static let searchImageViewSide: CGFloat = 20.0
    }
    
    // MARK: - property
    
    var networkManager = NetworkManager()

    private lazy var searchStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var topView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var searchImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: Constants.searchImageViewSide, height: Constants.searchImageViewSide))
        imageView.image = UIImage(named: Constants.searchImage)
        return imageView
    }()
    
    private lazy var searchTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = Constants.searchTextFieldLabel
        tf.borderStyle = .roundedRect
        tf.leftViewMode = .always
        tf.leftView = searchImageView
        return tf
    }()
    
    private var recipies: RecipeData?
    
    private lazy var tableView = UITableView()
    
    // MARK: - life cycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        configure()
        setConstraints()
        networkManager.delegate = self
        searchTextField.delegate = self
        if let tabBarItem = self.tabBarController?.tabBar.items?[3] {   // Change the image of the active picture tabBar
            tabBarItem.selectedImage = UIImage(systemName: Constants.tabBarImage)
                        }
    }
    
    override func viewDidLayoutSubviews() {
        tableView.frame = view.safeAreaLayoutGuide.layoutFrame
    }
    
// MARK: - flow funcs
    private func configure() {
        configureView()
        configureTableView()
    }
    
    private func addSubViews() {
        view.addSubview(searchStackView)
        searchStackView.addArrangedSubview(topView)
        searchStackView.addArrangedSubview(tableView)
        topView.addSubview(searchTextField)
    }
    
    func configureView() {
        view.backgroundColor = UIColor.white
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorColor = .clear
    }
    
    @objc func searchTapped(_ sender: Any) {
        searchTextField.endEditing(true)
        guard let city = searchTextField.text else {
            return
        }
        print(city)
    }
    
    private func setConstraints() {
        searchStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: searchStackView.topAnchor),
            topView.leadingAnchor.constraint(equalTo: searchStackView.leadingAnchor, constant: Constants.topViewSideSpacing),
            topView.trailingAnchor.constraint(equalTo: searchStackView.trailingAnchor, constant: -Constants.topViewSideSpacing),
            topView.heightAnchor.constraint(equalToConstant: Constants.topViewHeight),
        ])
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: topView.topAnchor),
            searchTextField.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            searchTextField.trailingAnchor.constraint(equalTo: topView.trailingAnchor),
            searchTextField.heightAnchor.constraint(equalToConstant: Constants.searchTFHeight)
        ])

        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: Constants.tableViewTopSpacing),
            tableView.bottomAnchor.constraint(equalTo: searchStackView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: searchStackView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: searchStackView.trailingAnchor)
        ])
    }
}

// MARK: - Delegate
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.heightForRow
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let counting = recipies?.results.count else {
            return 0
        }
        return counting
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchTableViewCell
        guard let recipies = recipies?.results else {
            return SearchTableViewCell()
        }
        cell.configure(with: (recipies[indexPath.row]))
        let item = recipies[indexPath.row].image
        let url = URL(string: item ?? "")
        cell.icon.kf.setImage(with: url)
        cell.tintColor = .specialBlack
        cell.selectionStyle = .none
        return  cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let сontroller = RecipeViewController()
        let item = recipies?.results[indexPath.row]
        сontroller.makeLabel.text = item?.title
        сontroller.recipeId = item?.id ?? 0
        let url = URL(string: item?.image ?? "")
        сontroller.recipeImageView.kf.setImage(with: url)
        present(сontroller, animated: true, completion: nil)
    }
}

extension SearchViewController: NetworkManagerDelegate {
    func RecipesDidRecive(_ dataFromApi: RecipeData) {
        recipies = dataFromApi
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print("Error: \(error)")
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let query = searchTextField.text else {
            return
        }
        networkManager.getRecipes(.search(query))
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
}


