//
//  ItemTableViewCell.swift
//  Fetch Coding
//
//  Created by Kalyan Chakravarthy Narne on 5/23/23.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    private lazy var itemImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 0.2
        imageView.layer.shadowOffset = CGSize(width: 0, height: 2)
        imageView.layer.shadowRadius = 4
        return imageView
    }()
    
    private lazy var itemName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Constants.font.helveticaBold, size: 18)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        heightAnchor.constraint(equalToConstant: 150).isActive = true
        backgroundColor = .clear
        configureImageView()
        configureItemName()
    }
    
    func setUp(with item: Item) {
        itemImage.image = item.image
        itemName.text = item.name
    }
    
    private func configureImageView() {
        addSubview(itemImage)
        NSLayoutConstraint.activate([
            itemImage.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            itemImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            itemImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            itemImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
    private func configureItemName() {
        addSubview(itemName)
        NSLayoutConstraint.activate([
            itemName.leadingAnchor.constraint(equalTo: itemImage.leadingAnchor, constant: 15),
            itemName.bottomAnchor.constraint(equalTo: itemImage.bottomAnchor, constant: -10),
            itemName.trailingAnchor.constraint(equalTo: itemImage.trailingAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
