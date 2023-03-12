//
//  CategoryListViewController.swift
//  СookBook
//
//  Created by Alex on 26.02.2023.
//

import Kingfisher
import UIKit

final class CategoryViewController: UIViewController {
    
    private let networkManager = NetworkManager()
    
    private var idArray: [Int] = []
    
    private var dishes: [Dish] = []
    
    var currentCategoryName: String
    
    private lazy var categoryNameLabel: UILabel = {
        let label = UILabel()
        label.text = currentCategoryName.capitalized
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(categoryNameLabel)
        view.addSubview(tableView)
        setupConstraints()
        tableView.register(DishTableViewCell.self, forCellReuseIdentifier: "DishTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        fetchData()
        updateData()
    }
    
    init(categoryName: String) {
        self.currentCategoryName = categoryName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            categoryNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            categoryNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.topAnchor.constraint(equalTo: categoryNameLabel.bottomAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
        ])
    }
    
    
    private func updateData() {
        DatabaseManager.fetchRecipes()

        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipeVC = RecipeViewController()
        let currentID = idArray[indexPath.row]
        let currentDish = dishes[indexPath.row]
        recipeVC.recipeId = currentID
        recipeVC.makeLabel.text = currentDish.dishName
        
        if let imageURL = URL(string: currentDish.dishImage ?? "") {
            let task = URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
                if let imageData = data, let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        recipeVC.recipeImageView.image = image
                    }
                }
            }
            task.resume()
        }
        
        present(recipeVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dishes.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DishTableViewCell", for: indexPath) as? DishTableViewCell else { return UITableViewCell() }
        
        let dish = dishes[indexPath.row]
        
        let currentID = idArray[indexPath.row]
        
        cell.recipeId = currentID
        
        cell.dishLabel.text = dish.dishName
        
        cell.isSelectedFavorite = false
        if DatabaseManager.savedRecipes.contains(where: { $0.recipeID == idArray[indexPath.row] }) {
            cell.isSelectedFavorite = true
        }
        cell.configureHeartButton()
        
        if let imageURL = URL(string: dish.dishImage ?? "") {
            cell.dishImage.kf.setImage(with: imageURL)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        267
    }
}


extension CategoryViewController {
    func fetchData() {
        networkManager.fetchRecipes(category: currentCategoryName) { recipeIds, error in
            if let ids = recipeIds {
                self.idArray = ids
                print(self.idArray)
                var dishes: [Dish] = []
                let group = DispatchGroup()
                for id in self.idArray {
                    group.enter()
                    self.networkManager.searchRecipeById(by: id) { recipe in
                        let dish = Dish(dishName: recipe.title, dishImage: recipe.image)
                        dishes.append(dish)
                        print(dishes)
                        group.leave()
                    }
                }
                group.notify(queue: DispatchQueue.main) {
                    let filteredDishes = dishes.filter { $0.dishImage != nil }
                    self.dishes = filteredDishes
                    self.tableView.reloadData()
                }
            } else {
                print("error")
            }
        }
    }
}
