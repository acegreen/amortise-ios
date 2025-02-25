//
//  TextView.swift
//  amortise-ios
//
//  Created by Ace Green on 2022-07-28.
//

import SwiftUI

enum TextView_Type {
    case h1
    case h2
    case h3
    case h4
    case h5
    case h6
    case subtitle_1
    case subtitle_2
    case body_1
    case body_2
    case button
    case caption
    case overline
}

struct TextView: View {
    var text: String
    var type: TextView_Type
    var lineLimit: Int = 0
    var body: some View {
        switch type {
        case .h1: return Text(text).tracking(-1.5).modifier(SailecFontModifier(.bold, size: 96)).lineLimit(lineLimit == 0 ? .none : lineLimit)
        case .h2: return Text(text).tracking(-0.5).modifier(SailecFontModifier(.bold, size: 60)).lineLimit(lineLimit == 0 ? .none : lineLimit)
        case .h3: return Text(text).tracking(0).modifier(SailecFontModifier(.bold, size: 48)).lineLimit(lineLimit == 0 ? .none : lineLimit)
        case .h4: return Text(text).tracking(0.25).modifier(SailecFontModifier(.bold, size: 34)).lineLimit(lineLimit == 0 ? .none : lineLimit)
        case .h5: return Text(text).tracking(0).modifier(SailecFontModifier(.bold, size: 24)).lineLimit(lineLimit == 0 ? .none : lineLimit)
        case .h6: return Text(text).tracking(0.15).modifier(SailecFontModifier(.bold, size: 20)).lineLimit(lineLimit == 0 ? .none : lineLimit)
        case .subtitle_1: return Text(text).tracking(0.15).modifier(SailecFontModifier(.bold, size: 16)).lineLimit(lineLimit == 0 ? .none : lineLimit)
        case .subtitle_2: return Text(text).tracking(0.1).modifier(SailecFontModifier(.bold, size: 14)).lineLimit(lineLimit == 0 ? .none : lineLimit)
        case .body_1: return Text(text).tracking(0.5).modifier(SailecFontModifier(.regular, size: 16)).lineLimit(lineLimit == 0 ? .none : lineLimit)
        case .body_2: return Text(text).tracking(0.25).modifier(SailecFontModifier(.regular, size: 14)).lineLimit(lineLimit == 0 ? .none : lineLimit)
        case .button: return Text(text).tracking(1.25).modifier(SailecFontModifier(.bold, size: 14)).lineLimit(lineLimit == 0 ? .none : lineLimit)
        case .caption: return Text(text).tracking(0.4).modifier(SailecFontModifier(.medium, size: 12)).lineLimit(lineLimit == 0 ? .none : lineLimit)
        case .overline: return Text(text).tracking(1.5).modifier(SailecFontModifier(.bold, size: 10)).lineLimit(lineLimit == 0 ? .none : lineLimit)
        }
    }
}
