//
//  MainTableViewCell.swift
//  СookBook
//
//  Created by Aleksandra Asichka on 2023-02-28.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    //MARK: - property
    
    private lazy var cellStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 20
        stackView.backgroundColor = #colorLiteral(red: 0.9450981021, green: 0.9450981021, blue: 0.9450981021, alpha: 1)
        stackView.layer.cornerRadius = 12
        return stackView
    }()
    
    private lazy var icon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var descriptionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label  = UILabel()
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label  = UILabel()
        return label
    }()
    
    private lazy var bookmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
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
        addSubview(cellStackView)
        cellStackView.addArrangedSubview(icon)
        cellStackView.addArrangedSubview(descriptionStackView)
        descriptionStackView.addArrangedSubview(titleLabel)
        descriptionStackView.addArrangedSubview(timeLabel)
        cellStackView.addArrangedSubview(bookmarkImageView)
    }
    
    //MARK: - flow funcs
    func configure(with item: Item){
        guard let imageName = item.image,
              let title = item.title,
              let time = item.time,
              let bookmark = item.bookmark else { return }

        configureImage(with: imageName)
        configureTitle(with: title)
        configureTime(with: time)
        configureBookmark(with: bookmark)
    }
    
    func configureImage(with name: String) {
        icon.contentMode = .scaleAspectFill
        icon.clipsToBounds = true
        icon.image = UIImage(named: name)
    }

    func configureTitle(with text: String) {
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        titleLabel.numberOfLines = 2
        titleLabel.text = text
    }

    func configureTime(with time: Int) {
        timeLabel.text = "\(time) Mins"
        timeLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        timeLabel.textColor = .lightGray
        timeLabel.contentMode = .left
    }
    
    func configureBookmark(with name: String) {
        bookmarkImageView.contentMode = .scaleAspectFill
        bookmarkImageView.clipsToBounds = true
        bookmarkImageView.image = UIImage(named: name)
    }
    
    func setConstraints() {
        cellStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellStackView.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            cellStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            cellStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            cellStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
        ])
        icon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            icon.leadingAnchor.constraint(equalTo: cellStackView.leadingAnchor, constant: 20),
            icon.topAnchor.constraint(equalTo: cellStackView.topAnchor, constant: 20),
            icon.bottomAnchor.constraint(equalTo: cellStackView.bottomAnchor, constant: -20),
            icon.widthAnchor.constraint(equalToConstant: 64),
            //icon.heightAnchor.constraint(equalToConstant: 64)
        ])
        descriptionStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionStackView.widthAnchor.constraint(equalToConstant: 153),
            descriptionStackView.topAnchor.constraint(equalTo: cellStackView.topAnchor, constant: 29),
            descriptionStackView.bottomAnchor.constraint(equalTo: cellStackView.bottomAnchor, constant: -29),
            
            ])
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        bookmarkImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bookmarkImageView.topAnchor.constraint(equalTo: cellStackView.topAnchor, constant: 37),
            bookmarkImageView.trailingAnchor.constraint(equalTo: cellStackView.trailingAnchor, constant: -20),
            bookmarkImageView.bottomAnchor.constraint(equalTo: cellStackView.bottomAnchor, constant: -37),
            bookmarkImageView.widthAnchor.constraint(equalToConstant: 24),
            bookmarkImageView.heightAnchor.constraint(equalToConstant: 24),
        ])
    }
}
