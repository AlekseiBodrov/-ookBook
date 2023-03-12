//
//  SearchTableViewCell.swift
//  СookBook
//
//  Created by Admin on 11.03.23.
//

import UIKit
import Kingfisher

class SearchTableViewCell: UITableViewCell {

    // MARK: - constants
    enum Constants {
        static let iconImage: String = "heart.fill"
        static let iconImageViewWidth: CGFloat = 64.0
        static let cellBorderSize: CGFloat = 1.0
        static let heartButtonTopSpasing: CGFloat = 39.0
        static let heartButtonTrailingSpasing: CGFloat = -20.0
        static let iconViewSideSpacing: CGFloat = 20.0
        static let descriptionTimeHeight: CGFloat = 18.0
        static let descriptionTitleHeight: CGFloat = 40.0
        static let descriptionViewWidth: CGFloat = 175.0
        static let numberOfLines: Int = 0
        static let heartImageViewWidth: CGFloat = 24.0
        static let heartImageViewHeight: CGFloat = 24.0
        static let elementsHorizontalSpacing: CGFloat = 20.0
        static let topTimeSpasing: CGFloat = 8.0
        static let topTitleSpasing: CGFloat = 19.0
    }
    
    //MARK: - property
    
    var item: RecipeData.RecipeDescription!
    
    var icon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label  = UILabel()
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label  = UILabel()
        return label
    }()
    
    private lazy var heartButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: Constants.iconImage), for: .normal)
        button.tintColor = .specialBlack
        button.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(icon)
        contentView.addSubview(titleLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(heartButton)
        contentView.layer.borderColor = UIColor.specialGray.cgColor
        contentView.layer.borderWidth = Constants.cellBorderSize
    }
    
    //MARK: - flow funcs
    func configure(with item: RecipeData.RecipeDescription){
        self.item = item
        guard let imageName = item.image
        else { return }

        configureImage(with: imageName)
        configureTitle(with: item.title)
        configureTime(with: item.readyInMinutes)
    }

    
    func configureImage(with name: String) {
        icon.contentMode = .scaleAspectFill
        icon.clipsToBounds = true
        icon.rounded()

    }

    func configureTitle(with text: String?) {
        titleLabel.font = .poppinsBold14()
        titleLabel.numberOfLines = Constants.numberOfLines
        titleLabel.text = text
    }

    func configureTime(with time: Int?) {
        timeLabel.text = "\(time ?? .zero) Mins"
        timeLabel.font = .poppinsRegular12()
        timeLabel.textColor = .specialLightGray
        timeLabel.contentMode = .left
    }
    
    @objc private func favoriteButtonTapped(sender: UIButton) {
//        item.isFavorite?.toggle()
//        sender.tintColor = item.isFavorite! ? .specialPink : .specialBlack
        sender.tintColor = .specialRed
        print("Added to FAVORITE")
    }
    
    func setConstraints() {
        icon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            icon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.iconViewSideSpacing),
            icon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.iconViewSideSpacing),
            icon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.iconViewSideSpacing),
            icon.widthAnchor.constraint(equalToConstant: Constants.iconImageViewWidth),
        ])
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.topTitleSpasing),
            titleLabel.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: Constants.elementsHorizontalSpacing),
            titleLabel.widthAnchor.constraint(equalToConstant: Constants.descriptionViewWidth),
            titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: Constants.descriptionTitleHeight)
        ])
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.topTimeSpasing),
            timeLabel.heightAnchor.constraint(equalToConstant: Constants.descriptionTimeHeight),
            timeLabel.widthAnchor.constraint(equalToConstant: Constants.descriptionViewWidth),
            timeLabel.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: Constants.elementsHorizontalSpacing),
        ])
        heartButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heartButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.heartButtonTrailingSpasing),
            heartButton.widthAnchor.constraint(equalToConstant: Constants.heartImageViewWidth),
            heartButton.heightAnchor.constraint(equalToConstant: Constants.heartImageViewHeight),
            heartButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.heartButtonTopSpasing)
            ])
    }

    override func prepareForReuse() {
            super.prepareForReuse()
            icon.kf.cancelDownloadTask()
            icon.image = nil
        }
}
