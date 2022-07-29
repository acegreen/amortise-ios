//
//  DropdownButton.swift
//  amortise-ios
//
//  Created by Ace Green on 2022-07-28.
//

import SwiftUI

protocol DropdownOption: CustomStringConvertible, Identifiable, CaseIterable { }

struct DropdownButton: View {
    
    @Binding var shouldShowDropdown: Bool
    @Binding var displayText: String
    
    var options: [any DropdownOption]
    let mainColor: Color
    let backgroundColor: Color
    let cornerRadius: CGFloat
    let buttonHeight: CGFloat
    var onSelect: ((_ key: String) -> Void)?
    
    var body: some View {
        VStack {
            Button(action: {
                self.shouldShowDropdown.toggle()
            }) {
                HStack {
                    Text(displayText).foregroundColor(mainColor)
                    Spacer()
                    Image(systemName: self.shouldShowDropdown ? "chevron.up" : "chevron.down").foregroundColor(mainColor)
                }
            }
            .padding(.horizontal)
            .cornerRadius(cornerRadius)
            .frame(height: self.buttonHeight)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius).fill(backgroundColor)
            )
            VStack {
                if self.shouldShowDropdown {
                    CategoriesView(options: CategoryType.allCases, onSelect: onSelect)
                }
            }
        }.animation(.spring())
    }
}
