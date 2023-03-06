//
//  StepViewController.swift
//  СookBook
//
//  Created by Николай Игнатов on 06.03.2023.
//

import UIKit

final class StepViewController: UIViewController {
    
    private var steps: [Steps] = []
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "StepCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.allowsSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
   
        tableView.delegate = self
        tableView.dataSource = self
        
        NetworkManager.shared.searchRecipeInstructions(withId: 1) { recipes in
                  if let recipe = recipes.first {
                      self.steps = recipe.steps
                      DispatchQueue.main.async {
                          self.tableView.reloadData()
                      }
                  }
              }

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}


extension StepViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return steps.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StepCell", for: indexPath)
        let step = steps[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = "Step \(step.number): \(step.step)"
        return cell
    }
}
