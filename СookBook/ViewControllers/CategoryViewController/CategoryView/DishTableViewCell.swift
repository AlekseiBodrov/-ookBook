//
//  DishTableViewCell.swift
//  СookBook
//
//  Created by Николай Игнатов on 02.03.2023.
//

import Kingfisher
import UIKit

final class DishTableViewCell: UITableViewCell {
    
//    var databaseManager = DatabaseManager()
    
    var recipeId = 0
    var isSelectedFavorite = false
    
    let dishLabel: UILabel = {
        let title = UILabel()
        title.textColor = .white
        title.numberOfLines = 2
        title.font = .systemFont(ofSize: 24, weight: .bold)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    let dishImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .gray
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var heartButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        button.tintColor = .specialBlack
        button.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
          super.init(style: style, reuseIdentifier: reuseIdentifier)
          setupViews()
          setConstraints()
      }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dishImage.kf.cancelDownloadTask()
        dishImage.image = nil
        isSelectedFavorite = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        selectionStyle = .none
        addSubview(dishImage)
        addSubview(dishLabel)
        contentView.addSubview(heartButton)
    }
    
    @objc private func favoriteButtonTapped(sender: UIButton) {
        isSelectedFavorite = !isSelectedFavorite
        
        if isSelectedFavorite {
            sender.tintColor = .specialRed
            heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            DatabaseManager.saveRecipe(recipeID: Int64(self.recipeId))
            DatabaseManager.fetchRecipes()
        } else {
            sender.tintColor = .black
            heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    func configureHeartButton() {
        if isSelectedFavorite {
            heartButton.tintColor = .specialRed
            heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            DatabaseManager.saveRecipe(recipeID: Int64(self.recipeId))
            DatabaseManager.fetchRecipes()
        } else {
            heartButton.tintColor = .black
            heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    private func setConstraints(){
        NSLayoutConstraint.activate([
            dishLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            dishLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            dishLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -42),
            dishImage.topAnchor.constraint(equalTo: topAnchor),
            dishImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            dishImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            dishImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            
            heartButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            heartButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            heartButton.widthAnchor.constraint(equalToConstant: 44),
            heartButton.heightAnchor.constraint(equalToConstant: 44),
            
            bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            
        ])
    }
}
