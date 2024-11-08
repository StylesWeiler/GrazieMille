//
//  QuizHeader.swift
//  GrazieMille
//
//  Created by Styles Weiler on 10/26/24.
//

import SwiftUI

struct QuizHeader: View {
    let topicName: String
    @Binding var quizPassed: Bool
    @Binding var currentScore: Int
    let percentageScore: Int 
    let quizItems: [Language.QuizItem]
    let topicId: UUID
    let viewModel: LanguageViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("\(topicName) Quiz")
                    .font(.title)
                Spacer()
                Toggle("Passed", isOn: $quizPassed)
                    .onChange(of: quizPassed) { _, newValue in
                        viewModel.updateQuizStatus(
                            for: topicId,
                            passed: newValue,
                            score: percentageScore
                        )
                    }
                    .labelsHidden()
            }
            
            HStack {
                Text("Points: \(currentScore)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Spacer()
                
                Text("Score: \(percentageScore)%")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .padding()
    }
}
