//
//  FavoritesTableViewCell.swift
//  СookBook
//
//  Created by Dmitriy Babichev on 28.02.2023.
//

import UIKit

final class FavoritesTableViewCell: UITableViewCell {

    // MARK: - constants
    static let identifier = "FavoritesTableViewCell"

    // MARK: - properties
    private let recipeImage = UIImageView()
    private let recipeLabel = UILabel()

    // MARK: - life cycle funcs
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubViews()
        configureViews()
        configureLabels()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        recipeImage.image = nil
        recipeLabel.text = nil
    }

    // MARK: - flow funcs
    private func addSubViews() {
        contentView.addSubview(recipeImage)
        contentView.addSubview(recipeLabel)
    }

    private func configureViews() {
        contentView.backgroundColor = .white

        recipeImage.translatesAutoresizingMaskIntoConstraints = false
        recipeImage.image = UIImage(named: "recipe-1")
        recipeImage.contentMode = .scaleAspectFill
        recipeImage.layer.cornerRadius = 10
        recipeImage.clipsToBounds = true
    }

    private func configureLabels() {
        recipeLabel.translatesAutoresizingMaskIntoConstraints = false
        recipeLabel.text = "How to make french toast"
        recipeLabel.textAlignment = .natural
        recipeLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        recipeLabel.textColor = .specialBlack
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            recipeImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            recipeImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            recipeImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            recipeImage.heightAnchor.constraint(equalToConstant: 200),

            recipeLabel.topAnchor.constraint(equalTo: recipeImage.bottomAnchor),
            recipeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            recipeLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    public func configure(title: String, imageName: String) {
        recipeLabel.text = title
        recipeImage.image = UIImage(named: imageName)
    }
}
