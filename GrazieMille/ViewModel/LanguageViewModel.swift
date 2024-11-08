//
//  LanguageViewModel.swift
//  GrazieMille
//
//  Created by Styles Weiler on 10/20/24.
//

import Foundation

class LanguageViewModel: ObservableObject {
    @Published var progress: [Language.Progress]
    @Published var topics: [Language.Topic]
    private let lessonPlan: ItalianLesson
    
    init() {
        // Initialize basic properties first
        self.lessonPlan = ItalianLesson()
        self.topics = lessonPlan.topics
        
        // Initialize progress with saved data or create new
        let defaults = UserDefaults.standard
        if let savedData = defaults.data(forKey: "savedProgress") {
            do {
                let decoder = JSONDecoder()
                let loadedProgress = try decoder.decode([Language.Progress].self, from: savedData)
                print("Successfully loaded \(loadedProgress.count) progress items")
                self.progress = loadedProgress
            } catch {
                print("Error decoding saved progress: \(error)")
                self.progress = lessonPlan.topics.map { Language.Progress(topicId: $0.id) }
            }
        } else {
            print("No saved progress found, creating new")
            self.progress = lessonPlan.topics.map { Language.Progress(topicId: $0.id) }
        }
        
        // Debug: Print all topics and their IDs
        print("\nAll Topics and Their IDs:")
        for topic in topics {
            print("\(topic.title): \(topic.id)")
        }
        
        // Debug: Print current progress state
        printCurrentState()
    }
    
    private func saveProgress() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(progress)
            UserDefaults.standard.set(data, forKey: "savedProgress")
            UserDefaults.standard.synchronize()
            print("\nProgress saved. Current state:")
            printCurrentState()
        } catch {
            print("Error saving progress: \(error)")
        }
    }
    
    private func printCurrentState() {
        print("\nCurrent Progress State:")
        for topic in topics {
            if let topicProgress = progress.first(where: { $0.topicId == topic.id }) {
                print("\(topic.title):")
                print("  ID: \(topic.id)")
                print("  Vocab Studied: \(topicProgress.vocabStudied)")
                print("  Quiz Passed: \(topicProgress.quizPassed)")
                print("  Quiz Score: \(topicProgress.quizHighScore ?? -1)")
            }
        }
    }
    
    func updateVocabStudied(for topicId: UUID, studied: Bool) {
        print("\nUpdating vocab studied for \(topicId)")
        if let index = progress.firstIndex(where: { $0.topicId == topicId }) {
            var updatedProgress = progress
            updatedProgress[index].vocabStudied = studied
            progress = updatedProgress
            saveProgress()
            print("Vocab progress updated and saved")
        } else {
            print("Could not find progress for topic ID: \(topicId)")
        }
    }
    
    func updateQuizStatus(for topicId: UUID, passed: Bool, score: Int?) {
        print("\nUpdating quiz status for \(topicId)")
        if let index = progress.firstIndex(where: { $0.topicId == topicId }) {
            var updatedProgress = progress
            updatedProgress[index].quizPassed = passed
            if let newScore = score {
                updatedProgress[index].quizHighScore = max(newScore, progress[index].quizHighScore ?? 0)
            }
            progress = updatedProgress
            saveProgress()
            print("Quiz progress updated and saved")
        } else {
            print("Could not find progress for topic ID: \(topicId)")
        }
    }
    
    func getProgress(for topicId: UUID) -> Language.Progress? {
        return progress.first(where: { $0.topicId == topicId })
    }
}
