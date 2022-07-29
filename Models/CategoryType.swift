//
//  CategoryType.swift
//  amortise-ios
//
//  Created by Ace Green on 2022-07-28.
//

import Foundation

enum CategoryType: String, DropdownOption {

    case entertainment
    case food
    case housing
    case insurance
    case medical
    case others
    case personal
    case savings
    case transport
    case utilities

    var id: String {
        return "category_type_" + self.rawValue
    }

    var description: String {
        return self.rawValue.capitalized
    }
}
