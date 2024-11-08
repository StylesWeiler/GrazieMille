//
//  Flashcard.swift
//  GrazieMille
//
//  Created by Styles Weiler on 10/22/24.
//

import SwiftUI

struct Flashcard: View {
    var term: Language.Term
    
    @State private var isFaceUp: Bool = true
    @State private var rotation: Double = 0

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
                .frame(width: 300, height: 200)
                .shadow(radius: 5)
            
                Text(term.translation)
                    .font(.headline)
                    .padding()
                    .opacity(isFaceUp ? 1 : 0)
            
                Text(term.word)
                    .font(.headline)
                    .padding()
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                    .opacity(!isFaceUp ? 1 : 0)
        }
        .rotation3DEffect(
            .degrees(rotation),
            axis: (x: 0, y: 1, z: 0),
            perspective: 0.8
        )
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.6)) {
                rotation += 180
                isFaceUp.toggle()
            }
        }
    }
}
