//
//  CategoryData.swift
//  amortise-ios
//
//  Created by Ace Green on 2022-07-28.
//

import Foundation

enum Category: String, DropdownOption {

    case specialOffer = "Special Offer"
    case confectionery = "Confectionery"
    case crisps = "Crisps"
    case softDrinks = "Soft Drinks"
    case alcohol = "Alcohol"
    case fruitAndVeggies = "Fruit & Veggies"
    case meat = "Meat"
    case readyMeals = "Real Meals"
    case iceCream = "Ice Cream"
    case dairy = "Dairy"
    case food = "Food"
    case bakery = "Bakery"
    case frozenFood = "Frozen Food"
    case health = "Health"
    case personal = "Personal"
    case home = "Home"

    var id: String {
        switch self {
        case .specialOffer:
            return "category-1"
        case .confectionery:
            return "category-2"
        case .crisps:
            return "category-3"
        case .softDrinks:
            return "category-4"
        case .alcohol:
            return "category-5"
        case .fruitAndVeggies:
            return "category-6"
        case .meat:
            return "category-7"
        case .readyMeals:
            return "category-8"
        case .iceCream:
            return "category-9"
        case .dairy:
            return "category-10"
        case .food:
            return "category-11"
        case .bakery:
            return "category-12"
        case .frozenFood:
            return "category-13"
        case .health:
            return "category-14"
        case .personal:
            return "category-15"
        case .home:
            return "category-16"
        }
    }
}
