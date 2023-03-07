//
//  TrendsTableViewCell.swift
//  СookBook
//
//  Created by Aleksandra Asichka on 2023-03-02.
//

import UIKit

final class TrendsViewCell: UICollectionViewCell {

    //MARK: - property
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        label.text = "How to make ramen"
        return label
    }()

    //MARK: - life cycle funcs
    func configure(with name: String) {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        imageView.image = UIImage(named: name)
        
        setConstraint()
    }

    func setConstraint() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12).isActive = true
        imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
//        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
//        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
}
