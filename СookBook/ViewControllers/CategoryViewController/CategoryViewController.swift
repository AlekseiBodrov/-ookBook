//
//  ViewController.swift
//  СookBook
//
//  Created by Alex on 26.02.2023.
//

import UIKit

final class CategoryViewController: UIViewController {
    
    private let categoryArray: [DishCategory] = []
    
    private let dishes: [Dish] = [Dish(dishName: "Суп 1", dishImage: UIImage(systemName: "fork.knife")!), Dish(dishName: "Суп 2", dishImage: UIImage(systemName: "fork.knife.circle")!), Dish(dishName: "Суп 3", dishImage: UIImage(systemName: "fork.knife.circle.fill")!)]
    
    private let currentCategoryName = "Супы"
    
    private lazy var  categoryNameLabel: UILabel = {
        let label = UILabel()
        label.text = currentCategoryName
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
}

extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //     let detailViewController = DeteilViewController()
        //     navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dishes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DishTableViewCell", for: indexPath) as? DishTableViewCell else { return UITableViewCell() }
        let data = dishes[indexPath.row]
        cell.dishImage.image = data.dishImage
        cell.dishLabel.text = data.dishName
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        267
    }
}
