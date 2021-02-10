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
        .restaurant(Restaurant(restaurantImage: "LupoRestaurant", restaurantName: "A", restaurantCategory: [FilterCategory(name: "Mexican")], mealTime: [FilterCategory(name: "Breakfast")], cost: .low)),
        .restaurant(Restaurant(restaurantImage: "LupoRestaurant", restaurantName: "B", restaurantCategory: [FilterCategory(name: "Italian")], mealTime: [FilterCategory(name: "Lunch")], cost: .low)),
        .restaurant(Restaurant(restaurantImage: "LupoRestaurant", restaurantName: "C", restaurantCategory: [FilterCategory(name: "French")], mealTime: [FilterCategory(name: "Dinner")], cost: .low)),
        .restaurant(Restaurant(restaurantImage: "LupoRestaurant", restaurantName: "D", restaurantCategory: [FilterCategory(name: "Korean")], mealTime: [FilterCategory(name: "Breakfast")], cost: .low)),
        .restaurant(Restaurant(restaurantImage: "LupoRestaurant", restaurantName: "E", restaurantCategory: [FilterCategory(name: "American")], mealTime: [FilterCategory(name: "Dinner")], cost: .low)),
        .restaurant(Restaurant(restaurantImage: "LupoRestaurant", restaurantName: "F", restaurantCategory: [FilterCategory(name: "Korean")], mealTime: [FilterCategory(name: "Dinner")], cost: .low)),
        .restaurant(Restaurant(restaurantImage: "LupoRestaurant", restaurantName: "G", restaurantCategory: [FilterCategory(name: "Spanish")], mealTime: [FilterCategory(name: "Dinner")], cost: .low)),
        .restaurant(Restaurant(restaurantImage: "LupoRestaurant", restaurantName: "H", restaurantCategory: [FilterCategory(name: "Japanese")], mealTime: [FilterCategory(name: "Dinner")], cost: .low)),
        .restaurant(Restaurant(restaurantImage: "LupoRestaurant", restaurantName: "I", restaurantCategory: [FilterCategory(name: "French")], mealTime: [FilterCategory(name: "Dinner")], cost: .low)),
        .restaurant(Restaurant(restaurantImage: "LupoRestaurant", restaurantName: "J", restaurantCategory: [FilterCategory(name: "Spanish")], mealTime: [FilterCategory(name: "Dinner")], cost: .low)),
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

