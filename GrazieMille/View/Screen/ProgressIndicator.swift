//
//  ProgressIndicator.swift
//  GrazieMille
//
//  Created by Styles Weiler on 10/26/24.
//

import SwiftUI

struct ProgressIndicator: View {
    let completed: Bool
    let label: String
    
    var body: some View {
        if completed {
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(.green)
                .imageScale(.medium)
                .help(label) // Shows tooltip on hover (macOS)
                .accessibilityLabel(label) // For VoiceOver
        }
    }
}
