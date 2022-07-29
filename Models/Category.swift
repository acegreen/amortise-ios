//
//  CategoryData.swift
//  amortise-ios
//
//  Created by Ace Green on 2022-07-28.
//

import Foundation

enum Category: String, DropdownOption {

    case specialOffer
    case confectionery
    case crisps
    case softDrinks
    case alcohol
    case fruitAndVeggies
    case meat
    case readyMeals
    case iceCream
    case dairy
    case food
    case bakery
    case frozenFood
    case health
    case personal
    case household

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
        case .household:
            return "category-16"
        }
    }

    var description: String {
        switch self {
        case .specialOffer:
            return "Special Offer"
        case .confectionery:
            return "Confectionery"
        case .crisps:
            return "Crisps"
        case .softDrinks:
            return "Soft Drinks"
        case .alcohol:
            return "Alcohol"
        case .fruitAndVeggies:
            return "Fruit & Veggies"
        case .meat:
            return "Meat"
        case .readyMeals:
            return "Ready Meals"
        case .iceCream:
            return "Ice Cream"
        case .dairy:
            return "Dairy"
        case .food:
            return "Food"
        case .bakery:
            return "Bakery"
        case .frozenFood:
            return "Frozen Food"
        case .health:
            return "Health"
        case .personal:
            return "Personal"
        case .household:
            return "Household"
        }
    }
}
