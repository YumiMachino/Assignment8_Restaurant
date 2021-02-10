//
//  CategoryCollectionViewCell.swift
//  Assignment8_Restaurant
//
//  Created by Yumi Machino on 2021/02/06.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "CategoryCell"
    
    let categoryLabel = UILabel()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(categoryLabel)
        contentView.backgroundColor = .systemYellow
        contentView.layer.cornerRadius = 10
        categoryLabel.matchParent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(_ category: FilterCategory) {
        categoryLabel.text = category.name
    }
    
    override var isSelected: Bool {
        didSet {
            contentView.backgroundColor = isSelected ? .systemTeal : .systemYellow
            categoryLabel.textColor = isSelected ? .white : .black
        }
    }
}
