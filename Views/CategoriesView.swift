//
//  CategoriesView.swift
//  amortise-ios
//
//  Created by Ace Green on 2022-07-28.
//

import SwiftUI

struct CategoriesView: View {

    var options: [Category]
    var onSelect: ((_ key: String) -> Void)?
    
    var body: some View {
        LazyVGrid(columns: GRIDP_LAYOUT, spacing: 15,  content: {
            ForEach(self.options) { item in
                CategoryItemView(image: item.id,
                                 name: item.description,
                                 onSelect: onSelect)
            }
        })
    }
}

// MARK: - PREVIEW

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView(options: Category.allCases)
    }
}
