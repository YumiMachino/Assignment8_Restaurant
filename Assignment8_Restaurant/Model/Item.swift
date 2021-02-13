//
//  Item.swift
//  Assignment8_Restaurant
//
//  Created by Yumi Machino on 2021/02/09.
//

import Foundation

/// wrapper object for Restaurant & FilterCategory
enum Item: Hashable {
    
    case restaurant(Restaurant)
    case category(FilterCategory)
    
    var restaurant: Restaurant? {
        if case .restaurant(let restaurant) = self {
            return restaurant
        } else {
            return nil
        }
    }
    
    var category: FilterCategory? {
        if case .category(let category) = self {
            return category
        } else {
            return nil
        }
    }

    
    static let myrestaurants: [Item] = [
        .restaurant(Restaurant(id: 1, restaurantImage: "LupoRestaurant", restaurantName: "A", restaurantCategory: [FilterCategory(name: "Mexican")], mealTime: [FilterCategory(name: "Breakfast"), FilterCategory(name: "Lunch")], cost: .low)),
        .restaurant(Restaurant(id: 2, restaurantImage: "LupoRestaurant", restaurantName: "B", restaurantCategory: [FilterCategory(name: "Italian")], mealTime: [FilterCategory(name: "Lunch"), FilterCategory(name: "Dinner")], cost: .low)),
        .restaurant(Restaurant(id: 3, restaurantImage: "LupoRestaurant", restaurantName: "C", restaurantCategory: [FilterCategory(name: "French")], mealTime: [FilterCategory(name: "Dinner")], cost: .medium)),
        .restaurant(Restaurant(id: 4,restaurantImage: "LupoRestaurant", restaurantName: "D", restaurantCategory: [FilterCategory(name: "Korean")], mealTime: [FilterCategory(name: "Breakfast")], cost: .low)),
        .restaurant(Restaurant(id: 5,restaurantImage: "LupoRestaurant", restaurantName: "E", restaurantCategory: [FilterCategory(name: "American")], mealTime: [FilterCategory(name: "Dinner")], cost: .low)),
        .restaurant(Restaurant(id: 6,restaurantImage: "LupoRestaurant", restaurantName: "F", restaurantCategory: [FilterCategory(name: "Korean")], mealTime: [FilterCategory(name: "Dinner")], cost: .low)),
        .restaurant(Restaurant(id: 7,restaurantImage: "LupoRestaurant", restaurantName: "G", restaurantCategory: [FilterCategory(name: "Spanish")], mealTime: [FilterCategory(name: "Dinner")], cost: .high)),
        .restaurant(Restaurant(id: 8,restaurantImage: "LupoRestaurant", restaurantName: "H", restaurantCategory: [FilterCategory(name: "Japanese")], mealTime: [FilterCategory(name: "Dinner")], cost: .low)),
        .restaurant(Restaurant(id: 9,restaurantImage: "LupoRestaurant", restaurantName: "I", restaurantCategory: [FilterCategory(name: "French")], mealTime: [FilterCategory(name: "Lunch")], cost: .low)),
        .restaurant(Restaurant(id: 10,restaurantImage: "LupoRestaurant", restaurantName: "J", restaurantCategory: [FilterCategory(name: "Spanish")], mealTime: [FilterCategory(name: "Dinner")], cost: .low)),
    ]
    
    static let filterItem: [Item] = [
        .category(FilterCategory(name: "Mexican")),
        .category(FilterCategory(name: "Italian")),
        .category(FilterCategory(name: "Japanese")),
        .category(FilterCategory(name: "French")),
        .category(FilterCategory(name: "Korean")),
        .category(FilterCategory(name: "American")),
        .category(FilterCategory(name: "Spanish")),
        .category(FilterCategory(name: "Breakfast")),
        .category(FilterCategory(name: "Lunch")),
        .category(FilterCategory(name: "Dinner")),
    ]
}

