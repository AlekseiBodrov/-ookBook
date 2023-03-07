//
//  FavoritesViewController.swift
//  СookBook
//
//  Created by Dmitriy Babichev on 28.02.2023.
//

import UIKit

final class FavoritesViewController: UIViewController {

    // MARK: - properties
    private let tableView = UITableView()
    private var cellObjects = [FavoriteRecipe]()

    // MARK: - life cycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        configure()
        setConstraints()
    }

    // MARK: - flow funcs
    private func configure() {
        configureViews()
        configureTableView()
        configureCellObjects()
    }

    private func addSubViews() {
        view.addSubview(tableView)
    }

    private func configureViews() {
        view.backgroundColor = .white
    }

    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FavoritesTableViewCell.self, forCellReuseIdentifier: FavoritesTableViewCell.identifier)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func configureCellObjects() {
        let testObjects = [FavoriteRecipe(title: "How to make french toast", imageName: "recipe-1"),
                           FavoriteRecipe(title: "How to make sushi at home", imageName: "recipe-2"),
                           FavoriteRecipe(title: "Easy oatmeal recipe", imageName: "recipe-3")]
        cellObjects.append(contentsOf: testObjects)
    }
}

    // MARK: - UITableViewDataSource
extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellObjects.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesTableViewCell.identifier, for: indexPath) as? FavoritesTableViewCell else {
            return UITableViewCell()
        }

        let data = cellObjects[indexPath.row]
        cell.configure(title: data.title, imageName: data.imageName)

        return cell
    }
}

// MARK: - UITableViewDelegate
extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        250
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let сontroller = RecipeViewController()
        сontroller.makeLabel.text = cellObjects[indexPath.row].title
        сontroller.recipeImageView.image = UIImage(named: cellObjects[indexPath.row].imageName)
        present(сontroller, animated: true, completion: nil)
        print("Cell at \(indexPath.row) row tapped!")
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
            self.cellObjects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)
        }
        deleteAction.image = UIImage(systemName: "trash")?.withTintColor(.systemPink, renderingMode: .alwaysOriginal)
        deleteAction.backgroundColor = .systemGroupedBackground
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}

