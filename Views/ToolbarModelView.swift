//
//  ToolbarModelView.swift
//  amortise-ios
//
//  Created by Ace Green on 2022-07-28.
//

import UIKit
import SwiftUI

struct ToolbarModelView: View {
    
    var title: String
    var hasBackButt: Bool = true
    var button1Icon: String?
    var button2Icon: String?
    
    var backButtonClick: () -> ()
    var button1Method: (() -> ())?
    var button2Method: (() -> ())?
    
    var body: some View {
        ZStack {
            HStack {
                if hasBackButt {
                    Button(action: { self.backButtonClick() },
                        label: { Image("back_arrow").resizable().frame(width: 34.0, height: 34.0) })
                }
                Spacer()
                if let button2Method = self.button2Method {
                    Button(action: { button2Method() },
                           label: { Image(button2Icon ?? "").resizable().frame(width: 28.0, height: 28.0) }).padding(.horizontal, 8)
                }
                if let button1Method = self.button1Method {
                    Button(action: { button1Method() },
                           label: { Image(button1Icon ?? "").resizable().frame(width: 28.0, height: 28.0) }).padding(.horizontal, 8)
                }
            }
            HStack {
                TextView(text: title, type: .h6).foregroundColor(Color.text_primary_color)
                if !hasBackButt { Spacer() }
            }
        }.padding(16).padding(.top, 30).padding(.horizontal, 8).background(Color.secondary_color)
    }
}
