//
//  CategoryItemView.swift
//  amortise-ios
//
//  Created by Ace Green on 2022-07-28.
//

import SwiftUI

struct CategoryItemView: View {
    
    var image: String
    var name: String
    var onSelect: ((_ key: String) -> Void)?
    
    var body: some View {
        Button(action: {
            if let onSelect = self.onSelect {
                onSelect(self.image)
            }
        }) {
            VStack {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(color: .black.opacity(0.35), radius: 2)
                Text(name)
                    .font(.caption)
                    .foregroundColor(.black)
            }
        }
    }
}

struct CategoryItemView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryItemView(image: "category-1", name: "Special Offers")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
