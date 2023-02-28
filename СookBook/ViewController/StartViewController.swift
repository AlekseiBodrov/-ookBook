//
//  StartViewController.swift
//  СookBook
//
//  Created by Dmitriy Babichev on 27.02.2023.
//

import UIKit

final class StartViewController: UIViewController {

    // MARK: - property
    private let backgroundImage = UIImageView()
    private let mainLabel = UILabel()
    private let subheadingLabel = UILabel()
    private let startButton = UIButton(type: .system)
    private let darkOverlay = UIView()

    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20.0
        stack.alignment = .center
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        [mainLabel, subheadingLabel, startButton ].forEach({ stack.addArrangedSubview($0) })
        return stack
    }()

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
        configureLabel()
        configureButton()
    }

    private func addSubViews() {
        view.addSubview(backgroundImage)
        view.addSubview(darkOverlay)
        view.addSubview(stackView)
    }

    private func configureView() {
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.image = UIImage(named: "background_launchscreen")
        backgroundImage.contentMode = .scaleAspectFill

        darkOverlay.translatesAutoresizingMaskIntoConstraints = false
        darkOverlay.backgroundColor = .black
        darkOverlay.alpha = 0.18
    }

    private func configureLabel() {
        mainLabel.numberOfLines = 0
        mainLabel.text = "Let's Cooking"
        mainLabel.textAlignment = .center
        mainLabel.font = .systemFont(ofSize: 60, weight: .heavy)
        mainLabel.textColor = .white

        subheadingLabel.text = "Find best recipes for cooking"
        subheadingLabel.font = .preferredFont(forTextStyle: .body)
        subheadingLabel.textColor = .white
    }

    private func configureButton() {
        startButton.setTitle("Start cooking", for: .normal)
        startButton.setTitleColor(.white, for: .normal)
        startButton.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        startButton.backgroundColor = .systemPink
        startButton.layer.cornerRadius = 10
        startButton.addTarget(self, action: #selector(startCookingButtonTapped), for: .touchUpInside)
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            darkOverlay.topAnchor.constraint(equalTo: view.topAnchor),
            darkOverlay.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            darkOverlay.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            darkOverlay.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            startButton.widthAnchor.constraint(equalToConstant: 200),
            startButton.heightAnchor.constraint(equalToConstant: 50),

            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 3)
        ])
    }

    @objc private func startCookingButtonTapped() {
        let secondVC = ViewController()
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
}
