//
//  ContentView.swift
//  amortise-ios
//
//  Created by Ace Green on 2022-07-28.
//

import Foundation

class DetailsViewModel: ObservableObject {
    
    @Published var model: ItemCoreDataModel
    
    init(model: ItemCoreDataModel) { self.model = model }
    
    func favouriteMethod() {  }
    
    func messageMethod() {  }
    
    func adoptMethod() {  }
}
