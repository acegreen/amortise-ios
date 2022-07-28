//
//  amortiseApp.swift
//  amortise-ios
//
//  Created by Ace Green on 2022-07-28.
//

import SwiftUI

@main
struct amortiseApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
