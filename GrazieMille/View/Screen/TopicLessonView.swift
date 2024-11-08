//
//  TopicLessonView.swift
//  GrazieMille
//
//  Created by Styles Weiler on 10/26/24.
//

import SwiftUI

struct TopicLessonView: View {
    var topic: Language.Topic
    @ObservedObject var viewModel: LanguageViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(topic.lessonText)
                .font(.system(size: 22))
                .padding(.bottom, 10)
            
            VStack(alignment: .leading, spacing: 10) {
                ForEach(topic.vocabulary, id: \.word) { term in
                    HStack(alignment: .top) {
                        Text("•")
                            .font(.system(size: 22))
                        Text("'\(term.word)' means '\(term.translation)'")
                            .font(.system(size: 22))
                    }
                }
            }
            
            Spacer()
            
            HStack {
                NavigationLink {
                    VocabView(vocab: topic.vocabulary,
                             topicName: topic.title,
                             topicId: topic.id,
                             viewModel: viewModel)  // Pass viewModel here
                } label: {
                    Text("Practice vocab")
                        .font(.headline)
                        //.frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
                
                NavigationLink {
                    QuizScreen(quizItems: topic.quiz,
                             topicName: topic.title,
                             topicId: topic.id,
                             viewModel: viewModel)  // Pass viewModel here
                } label: {
                    Text("Take the quiz")
                        .font(.headline)
                        //.frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
            }
            .padding(.bottom)
        }
        .padding()
        .navigationTitle(topic.title)
    }
}
