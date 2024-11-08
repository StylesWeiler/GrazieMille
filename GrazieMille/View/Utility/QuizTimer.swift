//
//  QuizTimer.swift
//  GrazieMille
//
//  Created by Todd Weiler on 10/26/24.
//

import SwiftUI

struct QuizTimer: View {
    let bonusTime: Double
    
    private var formattedTime: String {
        let minutes = Int(bonusTime) / 60
        let seconds = Int(bonusTime) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    private var timerColor: Color {
        if bonusTime > 10 { return .green }
        if bonusTime > 5 { return .yellow }
        return .red
    }
    
    var body: some View {
        Text("Time Bonus: \(formattedTime)")
            .font(.headline)
            .foregroundColor(timerColor)
            .padding(.horizontal)
    }
}

