//
//  LottieView.swift
//  amortise-ios
//
//  Created by Ace Green on 2022-07-28.
//

import SwiftUI
import Lottie

enum LottieAnimationType: String {
    case gamma_chart_animation = "gamma-chart-animation"
    case sweat_grinning_emoji_animation = "sweat-grinning-emoji-animation"
}

struct LottieView: UIViewRepresentable {
    var animationType: LottieAnimationType
    var loopMode: LottieLoopMode = .loop
    var contentMode: UIView.ContentMode = .scaleAspectFit

    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView()
        return view
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {
        uiView.subviews.forEach({ $0.removeFromSuperview() })
        let animationView = AnimationView()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        uiView.addSubview(animationView)

        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: uiView.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: uiView.heightAnchor)
        ])

        animationView.animation = Animation.named(animationType.rawValue)
        animationView.contentMode = contentMode
        animationView.loopMode = loopMode
        animationView.play()
    }
}

struct LottieView_Previews: PreviewProvider {
    static var previews: some View {
        LottieView(animationType: .gamma_chart_animation)
    }
}
