//
//  VocabView.swift
//  GrazieMille
//
//  Created by Styles Weiler on 10/26/24.
//

import SwiftUI

struct VocabView: View {
    var vocab: [Language.Term]
    var topicName: String
    let topicId: UUID
    @ObservedObject var viewModel: LanguageViewModel
    @State private var isStudied: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Text("\(topicName) Vocab")
                    .font(.title)
                Spacer()
                Toggle("Studied", isOn: $isStudied)
                    .onChange(of: isStudied) { _, newValue in
                        viewModel.updateVocabStudied(for: topicId, studied: newValue)
                    }
                    .labelsHidden()
            }
            .padding()
            
            TabView {
                ForEach(vocab.shuffled(), id: \.word) { term in
                    Flashcard(term: term)
                        .padding()
                }
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
        }
        .onAppear {
            // Load saved state when view appears
            if let progress = viewModel.getProgress(for: topicId) {
                isStudied = progress.vocabStudied
            }
        }
    }
}
