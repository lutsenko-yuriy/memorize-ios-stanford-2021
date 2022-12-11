//
//  Cardify.swift
//  Memorize
//
//  Created by Yuriy Lutsenko on 11.12.2022.
//

import SwiftUI

struct Cardify: ViewModifier {
    var isFaceUp: Bool
    
    func body(content: Content) -> some View {
        ZStack(alignment: .center) {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if isFaceUp {
                shape.fill(.white)
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    .foregroundColor(.red)
            } else {
                shape.fill()
                    .foregroundColor(.red)
            }
            
            content.opacity(isFaceUp ? 1 : 0)
        }
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
    }
    
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        return self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
