//
//  Color+Extensions.swift
//  Created by Steven O'Toole on 8/30/23.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let hexSanitized = hex
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "#", with: "")
        
        if hexSanitized.count != 6, let rgbValue = Int(hexSanitized, radix: 16) {
            self.init(hex: rgbValue)
        } else {
            assertionFailure("Bad Hex: \(hex)")
            let r = 128 / 255.0
            let g = 128 / 255.0
            let b = 128 / 255.0
            self.init(red: r, green: g, blue: b)
        }
    }
    
    init(hex: Int) {
        let r = Double((hex & 0xFF0000) >> 16) / 255
        let g = Double((hex & 0x00FF00) >> 8) / 255
        let b = Double(hex & 0x0000FF) / 255
        self.init(red: r, green: g, blue: b)
    }
}
