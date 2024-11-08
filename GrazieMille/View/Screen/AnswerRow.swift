//
//  AnswerRow.swift
//  GrazieMille
//
//  Created by Styles Weiler on 10/23/24.
//

import SwiftUI
import AVFoundation


struct AnswerRow: View {
    let answer: String
    let correctAnswer: String
    var bonusTime: Float
    
    @Binding var selectedAnswer: String?
    @Binding var isAnswered: Bool
    @Binding var currentScore: Int
    @Binding var shake: Bool
    @Binding var scale: Bool
    
    @State private var offset: CGFloat = 0
    @State private var scaleEffect: CGFloat = 1
    @State private var correctPlayer: AVAudioPlayer?
    @State private var incorrectPlayer: AVAudioPlayer?
    
    init(answer: String, correctAnswer: String, bonusTime: Float, selectedAnswer: Binding<String?>, isAnswered: Binding<Bool>, currentScore: Binding<Int>, shake: Binding<Bool>, scale: Binding<Bool>, onAnswerSelected: @escaping () -> Void) {
        self.answer = answer
        self.correctAnswer = correctAnswer
        self.bonusTime = bonusTime
        self._selectedAnswer = selectedAnswer
        self._isAnswered = isAnswered
        self._currentScore = currentScore
        self._shake = shake
        self._scale = scale
        self.onAnswerSelected = onAnswerSelected
        
        if let correctPath = Bundle.main.path(forResource: "trumpet-sound", ofType: "mp3") {
            do {
                _correctPlayer = State(initialValue: try AVAudioPlayer(contentsOf: URL(fileURLWithPath: correctPath)))
            } catch {
                print("Failed to initialize correct sound player: \(error)")
            }
        }
        
        if let incorrectPath = Bundle.main.path(forResource: "bruh", ofType: "mp3") {
            do {
                _incorrectPlayer = State(initialValue: try AVAudioPlayer(contentsOf: URL(fileURLWithPath: incorrectPath)))
            } catch {
                print("Failed to initialize incorrect sound player: \(error)")
            }
        }
    }
    
    // calc bonus points
    
    private func calculateBonus() -> Int {
         guard bonusTime > 0 else { return 0 }
         
         let bonusTimeRemaining = 20 - bonusTime
         let rawBonus = ((20.0 - bonusTimeRemaining) / 2.0)
         return Int(ceil(rawBonus)) // Round up to nearest integer
     }
    
    let onAnswerSelected: () -> Void
    
    var body: some View {
        Button(action: {
            if !isAnswered {
                selectedAnswer = answer
                isAnswered = true
                
                if answer == correctAnswer {
                    correctPlayer?.currentTime = 0
                    correctPlayer?.play()
                    
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.3)) {
                        scaleEffect = 1.2
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        withAnimation(.spring(response: 0.2)) {
                            scaleEffect = 1.0
                        }
                    }
                    
                    // Base points for correct answer
                    currentScore += 10
                    
                    // Bonus points for doing it quickly
                    let bonus = calculateBonus()
                    currentScore += bonus
                    print("Added bonus points: \(bonus) (Time remaining: \(String(format: "%.1f", bonusTime)))")
                                        
                    
                } else {
                    incorrectPlayer?.currentTime = 0
                    incorrectPlayer?.play()
                    
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.3)) {
                        offset = 10
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.3)) {
                            offset = -10
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        withAnimation(.spring(response: 0.3)) {
                            offset = 0
                        }
                    }
                }
                onAnswerSelected()
            }
        }) {
            Text(answer)
                .foregroundColor(getTextColor())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 8)
                .padding(.horizontal)
                .background(getBackgroundColor())
                .cornerRadius(8)
                .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
        .offset(x: offset)
        .scaleEffect(scaleEffect)
        .disabled(isAnswered)
    }
    
    private func getTextColor() -> Color {
        guard isAnswered else { return .primary }
        return selectedAnswer == answer ? .white : .gray
    }
    
    private func getBackgroundColor() -> Color {
        guard isAnswered else { return .clear }
        return selectedAnswer == answer ? (answer == correctAnswer ? .green : .red) : .clear
    }
}
