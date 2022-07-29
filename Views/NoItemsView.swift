//
//  NoItemsView.swift
//  amortise
//
//  Created by Ace Green on 2022-07-29.
//

import SwiftUI

struct NoItemsView: View {
    var body: some View {
        VStack {
            LottieView(animationType: .gamma_chart_animation)
                    .frame(width: 300, height: 300)
            VStack {
                TextView(text: "No Items Yet!", type: .h6)
                    .foregroundColor(Color.text_primary_color)
                TextView(text: "Add a item and it will show up here", type: .body_1)
                    .foregroundColor(Color.text_primary_color).padding(.top, 2)
            }
        }
        .padding(.horizontal)
    }
}

struct NoItemsView_Previews: PreviewProvider {
    static var previews: some View {
        NoItemsView()
    }
}
