//
//  NavigationButtons.swift
//  GrazieMille
//
//  Created by Styles Weiler on 10/26/24.
//

import SwiftUI

struct NavigationButtons: View {
    let currentIndex: Int
    let maxIndex: Int
    let onPrevious: () -> Void
    let onNext: () -> Void
    
    var body: some View {
        HStack {
            Button(action: onPrevious) {
                Text("Previous")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(currentIndex > 0 ? Color.blue : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(.horizontal)
            }
            .disabled(currentIndex == 0)
            
            Button(action: onNext) {
                Text("Next")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(currentIndex < maxIndex - 1 ? Color.blue : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(.horizontal)
            }
            .disabled(currentIndex == maxIndex - 1)
        }
        .padding(.bottom)
    }
}
