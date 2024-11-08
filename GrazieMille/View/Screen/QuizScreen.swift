//
//  QuizScreen.swift
//  GrazieMille
//
//  Created by Styles Weiler on 10/26/24.
//

import SwiftUI

struct QuizScreen: View {
    let quizItems: [Language.QuizItem]
    let topicName: String
    let topicId: UUID
    @ObservedObject var viewModel: LanguageViewModel
    
    @State private var selectedAnswers: [Int: String] = [:]
    @State private var currentQuestionIndex = 0
    @State private var answeredQuestions: [Bool]
    @State private var quizPassed = false
    @State private var currentScore = 0
    @State private var shake = false
    @State private var scale = false
    @State private var bonusTime = 20.0
    @State private var timer: Timer?
    @State private var showCompletionAlert = false
    
    init(quizItems: [Language.QuizItem], topicName: String, topicId: UUID, viewModel: LanguageViewModel) {
        self.quizItems = quizItems
        self.topicName = topicName
        self.topicId = topicId
        self.viewModel = viewModel
        _answeredQuestions = State(initialValue: Array(repeating: false, count: quizItems.count))
    }
    
    private var isQuizComplete: Bool {
        answeredQuestions.allSatisfy { $0 }
    }
    
    private var correctAnswersCount: Int {
        var count = 0
        for (index, answer) in selectedAnswers {
            if answer == quizItems[index].correctAnswer {
                count += 1
            }
        }
        return count
    }
    
    private var isPerfectScore: Bool {
        correctAnswersCount == quizItems.count
    }
    
    private var currentPercentageScore: Int {
            return Int((Double(correctAnswersCount) / Double(quizItems.count)) * 100)
    }
    
    private func checkQuizCompletion() {
        guard isQuizComplete else { return }
        
        // Get current high score if it exists
        let currentHighScore = viewModel.getProgress(for: topicId)?.quizHighScore ?? 0
        
        // Only update if new score is higher
        if currentPercentageScore > currentHighScore {
            print("New high score achieved: \(currentPercentageScore)%")
            viewModel.updateQuizStatus(
                for: topicId,
                passed: isPerfectScore,
                score: currentPercentageScore
            )
        }
        
        // If all questions are correct, mark as passed
        if isPerfectScore && !quizPassed {
            print("Perfect score achieved! Marking quiz as passed")
            quizPassed = true
            viewModel.updateQuizStatus(
                for: topicId,
                passed: true,
                score: currentPercentageScore
            )
        }
        
        showCompletionAlert = true
    }
    
    var body: some View {
        VStack(spacing: 0) {
            QuizHeader(
                topicName: topicName,
                quizPassed: $quizPassed,
                currentScore: $currentScore,
                percentageScore: currentPercentageScore,
                quizItems: quizItems,
                topicId: topicId,
                viewModel: viewModel
            )
            
            QuizTimer(bonusTime: bonusTime)
            
            Spacer()
            
            Form {
                QuestionView(
                    question: quizItems[currentQuestionIndex],
                    questionIndex: currentQuestionIndex,
                    bonusTime: bonusTime,
                    selectedAnswer: $selectedAnswers[currentQuestionIndex],
                    isAnswered: $answeredQuestions[currentQuestionIndex],
                    currentScore: $currentScore,
                    shake: $shake,
                    scale: $scale,
                    onAnswerSelected: {
                        // Check completion after each answer
                        checkQuizCompletion()
                    }
                )
            }
            
            Spacer()
            
            NavigationButtons(
                currentIndex: currentQuestionIndex,
                maxIndex: quizItems.count,
                onPrevious: {
                    if currentQuestionIndex > 0 {
                        currentQuestionIndex -= 1
                        resetBonusTimer()
                    }
                },
                onNext: {
                    if currentQuestionIndex < quizItems.count - 1 {
                        currentQuestionIndex += 1
                        resetBonusTimer()
                    }
                }
            )
        }
        .onAppear {
            if let progress = viewModel.getProgress(for: topicId) {
                quizPassed = progress.quizPassed
                
                if let savedScore = progress.quizHighScore {
                    print("Loaded saved score: \(savedScore)%")
                }
            }
            startBonusTimer()
        }
        .onDisappear {
            timer?.invalidate()
            timer = nil
        }
        .onChange(of: answeredQuestions[currentQuestionIndex]) { _, isAnswered in
            if isAnswered {
                timer?.invalidate()
                timer = nil
            }
        }
        .alert("Quiz Complete!", isPresented: $showCompletionAlert) {
            Button("OK") { }
        } message: {
            Text(getCompletionMessage())
        }
    }
    
    private func getCompletionMessage() -> String {
        var message = "Your score: \(currentPercentageScore)%\n"
        message += "Correct answers: \(correctAnswersCount) out of \(quizItems.count)\n"
        
        if isPerfectScore {
            message += "\nCongratulations! You got a perfect score!"
        } else if let highScore = viewModel.getProgress(for: topicId)?.quizHighScore,
                  currentPercentageScore > highScore {
            message += "\nNew high score achieved!"
        }
        
        return message
    }
    
    private func startBonusTimer() {
        bonusTime = 20.0
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            if bonusTime > 0 && !answeredQuestions[currentQuestionIndex] {
                bonusTime -= 0.1
            } else if bonusTime <= 0 {
                bonusTime = 0
                timer?.invalidate()
            }
        }
    }
    
    private func resetBonusTimer() {
        startBonusTimer()
    }
}

struct QuestionView: View {
    let question: Language.QuizItem
    let questionIndex: Int
    let bonusTime: Double
    @Binding var selectedAnswer: String?
    @Binding var isAnswered: Bool
    @Binding var currentScore: Int
    @Binding var shake: Bool
    @Binding var scale: Bool
    let onAnswerSelected: () -> Void
    
    var body: some View {
        Section(header: Text("Question \(questionIndex + 1)")) {
            Text(question.question)
                .font(.headline)
                .padding(.vertical, 8)
            
            ForEach(question.answers, id: \.self) { answer in
                AnswerRow(
                    answer: answer,
                    correctAnswer: question.correctAnswer,
                    bonusTime: Float(bonusTime),
                    selectedAnswer: $selectedAnswer,
                    isAnswered: $isAnswered,
                    currentScore: $currentScore,
                    shake: $shake,
                    scale: $scale,
                    onAnswerSelected: onAnswerSelected
                )
                .padding(.vertical, 4)
            }
        }
    }
}
