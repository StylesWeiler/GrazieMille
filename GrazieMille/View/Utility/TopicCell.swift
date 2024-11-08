//
//  TopicCell.swift
//  GrazieMille
//
//  Created by Todd Weiler on 10/26/24.
//

import SwiftUI

struct TopicCell: View {
    var topic: Language.Topic
    @ObservedObject var viewModel: LanguageViewModel
    
    var progress: Language.Progress? {
        viewModel.getProgress(for: topic.id)
    }
    
    var body: some View {
        HStack {
            NavigationLink {
                TopicLessonView(topic: topic, viewModel: viewModel)
            } label: {
                HStack {
                    VStack(alignment: .leading) {
                        Text(topic.title)
                            .font(.headline)
                        
                        if let progress = progress {
                            HStack(spacing: 8) {
                                // Only show vocabulary status if completed
                                if progress.vocabStudied {
                                    HStack(spacing: 4) {
                                        Text("Vocabulary")
                                            .font(.caption)
                                        Image(systemName: "checkmark.circle.fill")
                                            .imageScale(.small)
                                    }
                                    .foregroundColor(.green)
                                }
                                
                                // Show score even if not "completed" (100%)
                                if let score = progress.quizHighScore {
                                    Text("Quiz Score: \(score)%")
                                        .font(.caption)
                                        .foregroundColor(.green)
                                }
                            }
                        }
                    }
                }
            }
        }
        .padding(.vertical, 4)
    }
}
