//
//  DishTableViewCell.swift
//  СookBook
//
//  Created by Николай Игнатов on 02.03.2023.
//

import UIKit

final class DishTableViewCell: UITableViewCell {
    
    let dishLabel: UILabel = {
        let title = UILabel()
        title.textColor = .white
        title.numberOfLines = 2
        title.font = .systemFont(ofSize: 16, weight: .bold)
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .white
        selectionStyle = .none
        addSubview(dishImage)
        addSubview(dishLabel)
        
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
            bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
