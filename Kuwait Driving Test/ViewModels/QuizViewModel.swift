//
//  QuizViewModel.swift
//  Kuwait Driving Test
//
//  Created by Tarek Chaalan on 8/31/25.
//

import Foundation
import SwiftUI

enum QuizMode: String, CaseIterable, Codable {
    case standard = "Standard Test"
    case regularOnly = "Regular Questions Only"
    case criticalOnly = "Critical Questions Only"
    case trueFalseOnly = "True/False Questions Only"
    case imageOnly = "Questions with Images Only"
    case savedOnly = "Saved Questions Only"
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

    // Pinned questions
    @Published private(set) var pinnedQuestionIds: Set<Int> = []

    // For accessibility/haptics
    let feedback = UINotificationFeedbackGenerator()

    // History
    @Published private(set) var history: [QuizAttempt] = []

    init() {
        self.allQuestions = QuestionLoader.load()
        // Keep deterministic order
        loadPinned()
        loadHistory()
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
        case .savedOnly:
            startSavedOnlyQuiz()
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

    private func startSavedOnlyQuiz() {
        guard !pinnedQuestionIds.isEmpty else {
            self.questions = []
            return
        }
        let saved = allQuestions.filter { pinnedQuestionIds.contains($0.id) }
        self.questions = saved.shuffled()
    }

    func reshuffleSavedQuestionsForQuiz() {
        guard quizMode == .savedOnly else { return }
        let saved = allQuestions.filter { pinnedQuestionIds.contains($0.id) }
        self.questions = saved.shuffled()
        currentIndex = 0
        selectedAnswerIndex = nil
        correctCount = 0
        answeredCriticalWrong = false
    }

    // MARK: - Navigation helpers (for Saved study-like UI)
    func goToPreviousQuestion() {
        guard currentIndex > 0 else { return }
        currentIndex -= 1
    }

    func goToNextQuestion() {
        guard currentIndex + 1 < questions.count else { return }
        currentIndex += 1
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
        let result = QuizResult(
            total: total,
            correct: correctCount,
            passed: passed,
            failedCritical: answeredCriticalWrong,
            passingScore: passingScore
        )
        state = .finished(result)
        appendHistory(from: result)
    }

    func restart() {
        state = .idle
    }

    func exitStudyMode() {
        state = .idle
        quizMode = .standard
    }

    // MARK: - History Persistence

    private let historyStoreKey = "QuizAttemptHistory"

    private func loadHistory() {
        guard let data = UserDefaults.standard.data(forKey: historyStoreKey) else { return }
        do {
            let decoded = try JSONDecoder().decode([QuizAttempt].self, from: data)
            history = decoded.sorted { $0.date > $1.date }
        } catch {
            // ignore decode errors
        }
    }

    private func saveHistory() {
        do {
            let data = try JSONEncoder().encode(history)
            UserDefaults.standard.set(data, forKey: historyStoreKey)
        } catch {
            // ignore encode errors
        }
    }

    private func appendHistory(from result: QuizResult) {
        let attempt = QuizAttempt(
            id: UUID(),
            date: Date(),
            mode: quizMode,
            total: result.total,
            correct: result.correct,
            passed: result.passed,
            failedCritical: result.failedCritical,
            passingScore: result.passingScore
        )
        history.insert(attempt, at: 0)
        if history.count > 200 { history.removeLast(history.count - 200) }
        saveHistory()
    }

    // MARK: - Pinning

    private let pinnedStoreKey = "PinnedQuestionIds"

    private func loadPinned() {
        if let stored = UserDefaults.standard.array(forKey: pinnedStoreKey) as? [Int] {
            pinnedQuestionIds = Set(stored)
        }
    }

    private func savePinned() {
        UserDefaults.standard.set(Array(pinnedQuestionIds), forKey: pinnedStoreKey)
    }

    func isPinned(_ question: QuizQuestion) -> Bool {
        pinnedQuestionIds.contains(question.id)
    }

    func togglePin(_ question: QuizQuestion) {
        if pinnedQuestionIds.contains(question.id) {
            pinnedQuestionIds.remove(question.id)
        } else {
            pinnedQuestionIds.insert(question.id)
        }
        savePinned()

        // If currently in Saved mode, immediately reflect removal/addition in active quiz set
        if quizMode == .savedOnly {
            // Keep current order for existing items, drop unpinned, and append any newly pinned not present
            let currentIds = Set(questions.map { $0.id })
            // Drop any that are no longer pinned
            questions.removeAll { !pinnedQuestionIds.contains($0.id) }
            // Append any newly pinned that weren't present
            let newlyPinned = allQuestions.filter { pinnedQuestionIds.contains($0.id) && !currentIds.contains($0.id) }
            if !newlyPinned.isEmpty {
                questions.append(contentsOf: newlyPinned.shuffled())
            }

            // Clamp current index
            if currentIndex >= questions.count {
                currentIndex = max(0, questions.count - 1)
            }
        }
    }

    // Expose saved questions list
    func savedQuestionsList() -> [QuizQuestion] {
        allQuestions.filter { pinnedQuestionIds.contains($0.id) }
    }

    // History management
    func removeHistory(at offsets: IndexSet) {
        history.remove(atOffsets: offsets)
        saveHistory()
    }
}
