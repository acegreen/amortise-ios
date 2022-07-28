//
//  Configs.swift
//  amortise-ios
//
//  Created by Ace Green on 2022-07-28.
//

import Foundation
import SwiftUI

// App Globals
let APP_NAME = "amortise"
let APP_LINK = "https://github.com/acegreen/amortise"

// Categories
let COLUMN_SPACING: CGFloat = 10
let ROW_SPACING: CGFloat = 10
var GRIDP_LAYOUT: [GridItem] {
    return Array(repeating: GridItem(.flexible(), spacing: ROW_SPACING), count: 4)
}

let CATEGORY_TYPE_TRANSPORT = "transport"
let CATEGORY_TYPE_FOOD = "food"
let CATEGORY_TYPE_HOUSING = "housing"
let CATEGORY_TYPE_INSURANCE = "insurance"
let CATEGORY_TYPE_MEDICAL = "medical"
let CATEGORY_TYPE_SAVINGS = "savings"
let CATEGORY_TYPE_PERSONAL = "personal"
let CATEGORY_TYPE_ENTERTAINMENT = "entertainment"
let CATEGORY_TYPE_OTHERS = "others"
let CATEGORY_TYPE_UTILITIES = "utilities"

func getTransTagIcon(transTag: String) -> String {
    switch transTag {
        case CATEGORY_TYPE_TRANSPORT: return "trans_type_transport"
        case CATEGORY_TYPE_FOOD: return "trans_type_food"
        case CATEGORY_TYPE_HOUSING: return "trans_type_housing"
        case CATEGORY_TYPE_INSURANCE: return "trans_type_insurance"
        case CATEGORY_TYPE_MEDICAL: return "trans_type_medical"
        case CATEGORY_TYPE_SAVINGS: return "trans_type_savings"
        case CATEGORY_TYPE_PERSONAL: return "trans_type_personal"
        case CATEGORY_TYPE_ENTERTAINMENT: return "trans_type_entertainment"
        case CATEGORY_TYPE_OTHERS: return "trans_type_others"
        case CATEGORY_TYPE_UTILITIES: return "trans_type_utilities"
        default: return "trans_type_others"
    }
}

func getTransTagTitle(transTag: String) -> String {
    switch transTag {
        case CATEGORY_TYPE_TRANSPORT: return "Transport"
        case CATEGORY_TYPE_FOOD: return "Food"
        case CATEGORY_TYPE_HOUSING: return "Housing"
        case CATEGORY_TYPE_INSURANCE: return "Insurance"
        case CATEGORY_TYPE_MEDICAL: return "Medical"
        case CATEGORY_TYPE_SAVINGS: return "Savings"
        case CATEGORY_TYPE_PERSONAL: return "Personal"
        case CATEGORY_TYPE_ENTERTAINMENT: return "Entertainment"
        case CATEGORY_TYPE_OTHERS: return "Others"
        case CATEGORY_TYPE_UTILITIES: return "Utilities"
        default: return "Unknown"
    }
}

// IMAGE_ICON NAMES
let IMAGE_BACK_ICON = "back_icon"
let IMAGE_FAV_ICON = "fav_icon"
let IMAGE_LOC_ICON = "loc_icon"
let IMAGE_MSG_ICON = "msg_icon"


let IMAGE_DELETE_ICON = "delete_icon"
let IMAGE_SHARE_ICON = "share_icon"
let IMAGE_FILTER_ICON = "filter_icon"
let IMAGE_OPTION_ICON = "settings_icon"

// MANUFACTURER IMAGE
let MANUFACTURER_IMAGE = "manufacturer_image"

// ITEMS_IMAGES
let ITEM_IMAGE_BLUE = "dog_blue"
let ITEM_IMAGE_ORANGE = "dog_orange"
let ITEM_IMAGE_RED = "dog_red"
let ITEM_IMAGE_WHITE = "dog_white"
let ITEM_IMAGE_YELLOW = "dog_yellow"
