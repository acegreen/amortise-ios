//
//  Configs.swift
//  amortise-ios
//
//  Created by Ace Green on 2022-07-28.
//

import Foundation
import SwiftUI

// App Globals
let APP_NAME = "amortise-ios"
let APP_LINK = "https://github.com/acegreen/amortise-ios"

// Categories
let COLUMN_SPACING: CGFloat = 10
let ROW_SPACING: CGFloat = 10
var GRIDP_LAYOUT: [GridItem] {
    return Array(repeating: GridItem(.flexible(), spacing: ROW_SPACING), count: 4)
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
