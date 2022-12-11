//
//  Cardify.swift
//  Memorize
//
//  Created by Yuriy Lutsenko on 11.12.2022.
//

import SwiftUI

struct Cardify: ViewModifier, Animatable {
    
    init(isFaceUp: Bool) {
        self.rotationDegrees = isFaceUp ? 0 : 180
    }
    
    var animatableData: Double {
        get { rotationDegrees }
        set { rotationDegrees = newValue }
    }
    var rotationDegrees: Double
    
    func body(content: Content) -> some View {
        ZStack(alignment: .center) {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if rotationDegrees < 90 {
                shape.fill(.white)
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    .foregroundColor(.red)
            } else {
                shape.fill()
                    .foregroundColor(.red)
            }
            
            content.opacity(rotationDegrees < 90 ? 1 : 0)
        }
        .rotation3DEffect(Angle.degrees(rotationDegrees), axis: (0, 1, 0))
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
