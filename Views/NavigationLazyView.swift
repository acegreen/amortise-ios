//
//  NavigationLazyView.swift
//  amortise-ios
//
//  Created by Ace Green on 2022-07-28.
//

import SwiftUI

// Lazy Navigation to load (constructor) after clicked on Button
struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) { self.build = build }
    var body: Content { build() }
}
