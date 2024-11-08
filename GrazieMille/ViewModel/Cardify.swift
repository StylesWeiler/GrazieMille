//
//  Cardify.swift
//  GrazieMille
//
//  Created by Styles Weiler on 10/22/24.
//

import SwiftUI


struct Cardify: ViewModifier {
    let isFaceUp: Bool
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: cornerRadius(for: geometry.size))
                    .fill(.white)
                
                RoundedRectangle(cornerRadius: cornerRadius(for: geometry.size))
                    .stroke(lineWidth: 2)
                
                content
                    .opacity(isFaceUp ? 1 : 0)
            }
            .shadow(radius: 5)
        }
    }
    
// MARK: - Drawing constants
    private func cornerRadius(for size: CGSize) -> Double {
        min(size.width, size.height) * 0.08

    }
    
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        modifier (Cardify(isFaceUp: isFaceUp))
        
    }
}
