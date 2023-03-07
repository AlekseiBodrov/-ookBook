//
//  CategoriesView.swift
//  СookBook
//
//  Created by Aleksandra Asichka on 2023-03-01.
//

import UIKit

final class CategoriesView: UIView {

    //MARK: - var\let
    lazy var sizeViewCategory = CGSize(width: 100, height: 32)
    lazy var componentsSpacing:CGFloat = 8

    lazy var categoriesArray = [String]()

    lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsHorizontalScrollIndicator = false
        return view
    }()

    //MARK: - life cycle funcs
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let size = CGSize(width: bounds.width, height: sizeViewCategory.height * 1.5)
        collection.frame = .init(x: 0, y: 0, width: size.width, height: size.height)
    }

    //MARK: - flow funcs
    private func setup() {
        collection.delegate = self
        collection.dataSource = self
        collection.register(CategoriesViewCell.self, forCellWithReuseIdentifier: "CategoriesViewCell")
        addSubview(collection)
    }
}

//MARK: - extension
extension CategoriesView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: componentsSpacing * 2, bottom: 0, right: componentsSpacing * 2)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return componentsSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return sizeViewCategory
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categoriesArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesViewCell", for: indexPath) as? CategoriesViewCell else { return UICollectionViewCell() }
        cell.configure(with: categoriesArray[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if let cell = collectionView.cellForItem(at: indexPath) as? CategoriesViewCell {
            return cell.didSelectItem()
        }

        let message = ["indexPath" : indexPath]
        NotificationCenter.default.post(name: NSNotification.Name("didSelectCategory"), object: nil, userInfo: message)
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CategoriesViewCell {
            cell.didDeselectItem()
        }
    }
}

