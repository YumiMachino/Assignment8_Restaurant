//
//  Restaurant.swift
//  Assignment8_Restaurant
//
//  Created by Yumi Machino on 2021/02/06.
//

import Foundation

struct Restaurant: Hashable {
    let id: Int
    let restaurantImage: String?
    let restaurantName: String
    let restaurantCategory: [FilterCategory]
    let mealTime: [FilterCategory]
    let cost: Cost
        
    enum Cost : String, Hashable {
        case low = "$"
        case medium = "$$"
        case high = "$$$"
    }
    
}
