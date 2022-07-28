//
//  ItemModel.swift
//  amortise-ios
//
//  Created by Ace Green on 2022-07-28.
//

import Foundation

struct ItemModel: Identifiable {
    var id: Int
    var name: String
    var age: Int
    var gender: String
    var color: String
    var weight: Double
    var location: String
    var image: String
    var about: String
    var manufacturer: ManufacturerModel
}
