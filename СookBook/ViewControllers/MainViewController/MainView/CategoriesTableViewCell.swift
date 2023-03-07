//
//  CategoriesTableViewCell.swift
//  СookBook
//
//  Created by Aleksandra Asichka on 2023-03-01.
//

import UIKit

final class CategoriesViewCell: UICollectionViewCell {

    //MARK: - property
    let view = UIView()
    let label = UILabel()

    //MARK: - flow funcs
    func configure(with name: String) {
        view.addSubview(label)
        contentView.addSubview(view)

        label.text = name
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.8859912753, green: 0.2405898869, blue: 0.2409880459, alpha: 1)

        view.backgroundColor = .white
        view.layer.cornerRadius = 10

        setConstraint()
    }

    func setConstraint() {
        view.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false

        view.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true

        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 8).isActive = true
        label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8).isActive = true
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
    }

    func didSelectItem() {
        view.backgroundColor  = #colorLiteral(red: 0.8859912753, green: 0.2405898869, blue: 0.2409880459, alpha: 1)
        label.textColor = .white
    }

    func didDeselectItem() {
        view.backgroundColor = .white
        label.textColor  = #colorLiteral(red: 0.8859912753, green: 0.2405898869, blue: 0.2409880459, alpha: 1)
    }
}

