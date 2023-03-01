//
//  MainViewController.swift
//  СookBook
//
//  Created by Aleksandra Asichka on 2023-02-27.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - constants
    
    // MARK: - property
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 0
        stackView.axis = .vertical
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var topView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var searchView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var receipeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = "Find best recipes for cooking"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private lazy var searchImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 16, y: 12, width: 20, height: 20))
        imageView.image = UIImage(named: "search")
        return imageView
    }()
    
    private lazy var searchTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Search recepies"
        tf.borderStyle = .roundedRect
        tf.leftViewMode = .always
        tf.leftView = searchImageView
        return tf
    }()
    
    private lazy var trendingScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private lazy var trendingContentView: UIView = {
        let view = UIView()
        return view
    }()
    
    let titleTrendLabel: UILabel = {
        let label = UILabel()
        label.text = "Trending now 🔥"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = UIColor.black
        return label
       }()
    
    private lazy var trendStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 20
        return stackView
    }()
    
//    private lazy var trendImageView: UIImageView = {
//        let imageView = UIImageView()
//        return imageView
//    }()
    private lazy var trendImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "video")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var bookmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bookmark")
        return imageView
    }()

    private lazy var trendImageView2: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "video2")
        return imageView
    }()

    private lazy var trendImageView3: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "video3")
        return imageView
    }()
    //private let trendsImages: [String] = ["video","video2","video3"]
    
    private let items: [Item] = [
    Item(id: 0, title: "Papper ramen", category: "Noodle", image: "ramen", bookmark: "bookmark", time: 10, isFavorite: false),
    Item(id: 1, title: "Sweet souse noodle", category: "Lunch", image: "ramen2", bookmark: "bookmark", time: 15, isFavorite: false),
    Item(id: 2, title: "Chicken soup", category: "Noodle", image: "ramen3", bookmark: "bookmark", time: 19, isFavorite: false)
    ]
    
    private let categories: [String] = ["Salad", "Breakfast", "Appetizer", "Noodle", "Lunch", "Dessert"]
    
    private var trends: [String]?
    private lazy var tableView = UITableView()
    private let viewForHeaderInSection = CategoriesView()
    
    // MARK: - life cycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        configure()
        setConstraints()
    }
    
// MARK: - flow funcs
    private func configure() {
        configureView()
        configureTableView()
        configureButton()
        
    }
    
    private func addSubViews() {
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(topView)
        topView.addSubview(receipeLabel)
        mainStackView.addArrangedSubview(searchView)
        searchView.addSubview(searchTextField)
        mainStackView.addArrangedSubview(trendingScrollView)
        trendingScrollView.addSubview(trendingContentView)
        trendingContentView.addSubview(titleTrendLabel)
        trendingContentView.addSubview(trendStackView)

//        for item in 0...trendsImages.count-1 {
//            let image = trendsImages[item]
//            trendImageView.image = UIImage(named: image)
//            trendStackView.addArrangedSubview(trendImageView)
//        }
        trendStackView.addArrangedSubview(trendImageView)
        trendStackView.addArrangedSubview(trendImageView2)
        trendStackView.addArrangedSubview(trendImageView3)
        mainStackView.addArrangedSubview(tableView)
    }
    
    func configureView() {
        view.backgroundColor = .white
        viewForHeaderInSection.categoriesArray = categories
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func configureButton() {
        
    }
    
    private func setConstraints() {
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  -20),
            mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        topView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: mainStackView.topAnchor),
            topView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: 98),
        ])
        receipeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            receipeLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            receipeLabel.topAnchor.constraint(equalTo: topView.topAnchor),
            receipeLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor),
            receipeLabel.heightAnchor.constraint(equalToConstant: 58),
            receipeLabel.widthAnchor.constraint(equalToConstant: 206),
        ])
        searchView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            searchView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            searchView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            searchView.heightAnchor.constraint(equalToConstant: 60),
        ])
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: searchView.topAnchor, constant: 8),
            searchTextField.leadingAnchor.constraint(equalTo: searchView.leadingAnchor),
            searchTextField.trailingAnchor.constraint(equalTo: searchView.trailingAnchor)
        ])
        trendingScrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            trendingScrollView.topAnchor.constraint(equalTo: searchView.bottomAnchor),
            trendingScrollView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            trendingScrollView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor)
        ])
        trendingContentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            trendingContentView.topAnchor.constraint(equalTo: trendingScrollView.topAnchor),
            trendingContentView.leadingAnchor.constraint(equalTo: trendingScrollView.leadingAnchor),
            trendingContentView.trailingAnchor.constraint(equalTo: trendingScrollView.trailingAnchor),
            trendingContentView.bottomAnchor.constraint(equalTo: trendingScrollView.bottomAnchor)
        ])
        titleTrendLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleTrendLabel.leadingAnchor.constraint(equalTo: trendingContentView.leadingAnchor),
            titleTrendLabel.topAnchor.constraint(equalTo: trendingContentView.topAnchor),
            titleTrendLabel.widthAnchor.constraint(equalTo: trendingContentView.widthAnchor, multiplier: 0.75)
        ])
        trendStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            trendStackView.topAnchor.constraint(equalTo: trendingContentView.topAnchor),
            trendStackView.leadingAnchor.constraint(equalTo: trendingContentView.leadingAnchor),
            trendStackView.trailingAnchor.constraint(equalTo: trendingContentView.trailingAnchor),
            trendStackView.bottomAnchor.constraint(equalTo: trendingContentView.bottomAnchor),
        ])
        trendImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            trendImageView.topAnchor.constraint(equalTo: titleTrendLabel.bottomAnchor, constant: 16),
            trendImageView.widthAnchor.constraint(equalToConstant: 280),
            trendImageView.heightAnchor.constraint(equalToConstant: 180),
        ])
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: trendStackView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor)
        ])
    }
}

// MARK: - Delegate
extension MainViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 104
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.viewForHeaderInSection
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 106
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MainTableViewCell
        cell.configure(with: items[indexPath.row])
        return  cell
    }
}
