//
//  StepViewController.swift
//  СookBook
//
//  Created by Николай Игнатов on 06.03.2023.
//

import UIKit

final class StepViewController: UIViewController {
    
    private let recipeID: Int
    
<<<<<<< HEAD
=======
    private var networkManager = NetworkManager()
    
>>>>>>> develop
    private var steps: [Steps] = []
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "StepCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    init (id: Int) {
        self.recipeID = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
<<<<<<< HEAD
   
        tableView.delegate = self
        tableView.dataSource = self
        
        NetworkManager.shared.searchRecipeInstructions(withId: recipeID) { recipes in
            if let recipe = recipes.first {
                      self.steps = recipe.steps
                      DispatchQueue.main.async {
                          self.tableView.reloadData()
                      }
                  }
              }

=======
        
        tableView.delegate = self
        tableView.dataSource = self
        
>>>>>>> develop
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
<<<<<<< HEAD
=======
        
        searchInstructions(forRecipeWithId: recipeID)
>>>>>>> develop
    }
}


extension StepViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
<<<<<<< HEAD
        return "Инструкция по приготовлению"
=======
        return "Steps for prepare"
>>>>>>> develop
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return steps.count
    }
<<<<<<< HEAD

=======
    
>>>>>>> develop
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StepCell", for: indexPath)
        let step = steps[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = "Step \(step.number): \(step.step)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else {
            return
        }
        
        let text = cell.textLabel
        cell.selectionStyle = .none
        
        if let attributedText = text?.attributedText {
            let newAttributedString: NSMutableAttributedString
            
            if attributedText.attribute(.strikethroughStyle, at: 0, effectiveRange: nil) != nil {
                newAttributedString = NSMutableAttributedString(string: attributedText.string)
            } else {
                newAttributedString = NSMutableAttributedString(attributedString: attributedText)
                newAttributedString.addAttribute(.strikethroughStyle,
<<<<<<< HEAD
                                                  value: NSUnderlineStyle.single.rawValue,
                                                  range: NSMakeRange(0, attributedText.length))
=======
                                                 value: NSUnderlineStyle.single.rawValue,
                                                 range: NSMakeRange(0, attributedText.length))
>>>>>>> develop
            }
            text?.attributedText = newAttributedString
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
<<<<<<< HEAD
=======

extension StepViewController {
    func searchInstructions(forRecipeWithId id: Int) {
        networkManager.searchRecipeInstructions(withId: id) { recipes in
            if let recipe = recipes.first {
                self.steps = recipe.steps
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}
>>>>>>> develop
