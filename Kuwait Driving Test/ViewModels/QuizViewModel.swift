//
//  QuizViewModel.swift
//  Kuwait Driving Test
//
//  Created by Tarek Chaalan on 8/31/25.
//

import Foundation
import SwiftUI

enum QuizMode: String, CaseIterable {
    case standard = "Standard Test"
    case regularOnly = "Regular Questions Only"
    case criticalOnly = "Critical Questions Only"
    case trueFalseOnly = "True/False Questions Only"
    case imageOnly = "Questions with Images Only"
    case study = "Study Mode"
}

@MainActor
final class QuizViewModel: ObservableObject {
    // Config
    let minQuestions = 20
    let maxQuestions = 170
    let passThreshold: Double = 0.75

    // Loaded pool
    private(set) var allQuestions: [QuizQuestion] = []

    // Quiz mode
    @Published private(set) var quizMode: QuizMode = .standard

    // Active quiz
    @Published private(set) var selectedCount: Int = 20
    @Published private(set) var state: QuizState = .idle
    @Published private(set) var questions: [QuizQuestion] = []
    @Published private(set) var currentIndex: Int = 0
    @Published private(set) var selectedAnswerIndex: Int? = nil
    @Published private(set) var correctCount: Int = 0
    @Published private(set) var answeredCriticalWrong: Bool = false

    // For accessibility/haptics
    let feedback = UINotificationFeedbackGenerator()

    init() {
        self.allQuestions = QuestionLoader.load()
        // Keep deterministic order
    }

    func setQuestionCount(_ count: Int) {
        selectedCount = max(minQuestions, min(maxQuestions, count))
    }

    func setQuizMode(_ mode: QuizMode) {
        quizMode = mode
    }

    func startQuiz() {
        feedback.prepare()

        switch quizMode {
        case .standard:
            startStandardQuiz()
        case .regularOnly:
            startRegularOnlyQuiz()
        case .criticalOnly:
            startCriticalOnlyQuiz()
        case .trueFalseOnly:
            startTrueFalseOnlyQuiz()
        case .imageOnly:
            startImageOnlyQuiz()
        case .study:
            startStudyMode()
        }

        currentIndex = 0
        selectedAnswerIndex = nil
        correctCount = 0
        answeredCriticalWrong = false
        state = .inProgress
    }

    private func startStandardQuiz() {
        // New distribution logic:
        // critical = round(0.05 * n)
        // true/false = round(0.15 * n)
        // image = round(0.25 * n)
        // regular = n - (crit + tf + img)

        let criticalCount = Int(round(0.05 * Double(selectedCount)))
        let tfCount = Int(round(0.15 * Double(selectedCount)))
        let imageCount = Int(round(0.25 * Double(selectedCount)))
        let regularCount = selectedCount - criticalCount - tfCount - imageCount

        // Get question pools
        let allCriticals = allQuestions.filter { $0.isCritical }
        let allTF = allQuestions.filter { $0.tf }
        let allImages = allQuestions.filter { $0.imageName != nil }
        let allRegular = allQuestions.filter { !$0.isCritical && !$0.tf && $0.imageName == nil }

        // Select questions from each pool
        let selectedCriticals = allCriticals.shuffled().prefix(criticalCount)
        let selectedTF = allTF.shuffled().prefix(tfCount)
        let selectedImages = allImages.shuffled().prefix(imageCount)
        let selectedRegular = allRegular.shuffled().prefix(regularCount)

        // Combine and shuffle
        var displayQuestions: [QuizQuestion] = []
        displayQuestions.append(contentsOf: selectedCriticals)
        displayQuestions.append(contentsOf: selectedTF)
        displayQuestions.append(contentsOf: selectedImages)
        displayQuestions.append(contentsOf: selectedRegular)

        self.questions = displayQuestions.shuffled()
    }

    private func startRegularOnlyQuiz() {
        let regularQuestions = allQuestions.filter { !$0.isCritical && !$0.tf && $0.imageName == nil }
        self.questions = regularQuestions.shuffled()
    }

    private func startCriticalOnlyQuiz() {
        let criticalQuestions = allQuestions.filter { $0.isCritical }
        self.questions = criticalQuestions.shuffled()
    }

    private func startTrueFalseOnlyQuiz() {
        let tfQuestions = allQuestions.filter { $0.tf }
        self.questions = tfQuestions.shuffled()
    }

    private func startImageOnlyQuiz() {
        let imageQuestions = allQuestions.filter { $0.imageName != nil }
        self.questions = imageQuestions.shuffled()
    }

    private func startStudyMode() {
        // For study mode, we'll use all questions but this will be handled differently in the UI
        self.questions = allQuestions.shuffled()
    }

    var progress: Double {
        guard !questions.isEmpty else { return 0 }
        return Double(currentIndex) / Double(questions.count)
    }

    var currentQuestion: QuizQuestion? {
        guard currentIndex >= 0 && currentIndex < questions.count else { return nil }
        return questions[currentIndex]
    }

    func selectAnswer(_ index: Int) {
        guard state == .inProgress else { return }
        selectedAnswerIndex = index
    }

    func submitAndAdvance() {
        guard state == .inProgress, let q = currentQuestion, let chosen = selectedAnswerIndex else { return }

        let isCorrect = (chosen == q.correctIndex)
        if isCorrect {
            correctCount += 1
            feedback.notificationOccurred(.success)
        } else {
            if q.isCritical {
                answeredCriticalWrong = true
                feedback.notificationOccurred(.error)
                finishQuiz()
                return
            } else {
                feedback.notificationOccurred(.warning)
            }
        }

        // Move to next
        selectedAnswerIndex = nil
        if currentIndex + 1 < questions.count {
            currentIndex += 1
        } else {
            finishQuiz()
        }
    }

    private func finishQuiz() {
        let total = questions.count
        let passingScore = Int(ceil(passThreshold * Double(total)))
        let passed = !answeredCriticalWrong && (correctCount >= passingScore)
        state = .finished(QuizResult(
            total: total,
            correct: correctCount,
            passed: passed,
            failedCritical: answeredCriticalWrong,
            passingScore: passingScore
        ))
    }

    func restart() {
        state = .idle
    }

    func exitStudyMode() {
        state = .idle
        quizMode = .standard
    }
}
