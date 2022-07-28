//
//  ContentView.swift
//  amortise-ios
//
//  Created by Ace Green on 2022-07-28.
//

import Foundation
import CoreData
import SwiftUI

class HomeViewModel: ObservableObject {

    @Published var itemsList = [ItemModel]()

    init() { fetchItemsList() }

    func fetchItemsList() { itemsList = ItemData.items }

//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//    var items: FetchedResults<Item>
}
