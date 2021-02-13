//
//  RestaurantCollectionViewCell.swift
//  Assignment8_Restaurant
//
//  Created by Yumi Machino on 2021/02/06.
//

import UIKit

class RestaurantCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "RestaurantCell"
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "LupoRestaurant")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 16
        return imageView
    }()
    
    let nameLabel : UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let categoryLabel : UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = lb.font.withSize(10)
        return lb
    }()
    
    let mealTimeLabel : UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = lb.font.withSize(10)
        return lb
    }()
    
    let costLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textAlignment = .right
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let hStack = HorizontalStackView(arrangedSubviews: [nameLabel, costLabel], spacing: 0, alignment: .fill, distribution: .fillProportionally)
        let stackView = VerticalStackView(arrangedSubviews: [imageView, hStack, categoryLabel,mealTimeLabel], spacing: 0, alignment: .fill, distribution: .fillProportionally)
        contentView.addSubview(stackView)
        stackView.matchParent()
        contentView.layer.cornerRadius = 16
        contentView.backgroundColor = .systemGray5
        imageView.anchors(topAnchor: stackView.topAnchor, leadingAnchor: stackView.leadingAnchor, trailingAnchor: stackView.trailingAnchor, bottomAnchor: hStack.topAnchor)
        imageView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.7).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: hStack.widthAnchor, multiplier: 0.7).isActive = true
        hStack.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.10).isActive = true
        categoryLabel.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.10).isActive = true
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(restaurant: Restaurant) {
        self.nameLabel.text = restaurant.restaurantName
        self.costLabel.text = restaurant.cost.rawValue
        
        let num = restaurant.restaurantCategory.count
        var text = ""
        for index in 0...num - 1 {
            if index == num - 1 {
                text = text + "\(restaurant.restaurantCategory[index].name)"
            } else {
                text = text + "\(restaurant.restaurantCategory[index].name),"
            }
           
        }
        self.categoryLabel.text = text
        
        let mealTimeCount = restaurant.mealTime.count
        var mealTimeTxt = ""
        for index in 0...mealTimeCount - 1 {
            if index == mealTimeCount - 1 {
                mealTimeTxt = mealTimeTxt + "\(restaurant.mealTime[index].name)"
            } else {
                mealTimeTxt = mealTimeTxt + "\(restaurant.mealTime[index].name),"
            }
           
        }
        self.mealTimeLabel.text = mealTimeTxt
      
        
    }
}
