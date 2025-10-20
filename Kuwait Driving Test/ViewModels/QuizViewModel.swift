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
    case difficultOnly = "Difficult Topics"
    case difficultStudy = "Difficult Study"
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
    @Published private(set) var wrongQuestions: [QuizQuestion] = []

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

        // Reset per-quiz state
        wrongQuestions = []

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
        case .difficultOnly:
            startDifficultOnlyQuiz()
        case .difficultStudy:
            startDifficultStudy()
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
        // Target mix (approximate) with exact final count and no duplicates
        let requestedCritical = Int(round(0.05 * Double(selectedCount)))
        let requestedTF = Int(round(0.15 * Double(selectedCount)))
        let requestedImage = Int(round(0.25 * Double(selectedCount)))

        // Pools
        let allCriticals = allQuestions.filter { $0.isCritical }
        let allTF = allQuestions.filter { $0.tf }
        let allImages = allQuestions.filter { $0.imageName != nil }
        let allRegular = allQuestions.filter { !$0.isCritical && !$0.tf && $0.imageName == nil }

        var chosenIds = Set<Int>()
        var selected: [QuizQuestion] = []

        func take(upTo n: Int, from pool: [QuizQuestion]) {
            if n <= 0 { return }
            let picks = pool.shuffled().filter { !chosenIds.contains($0.id) }.prefix(n)
            for q in picks {
                selected.append(q)
                chosenIds.insert(q.id)
            }
        }

        // Try to satisfy category quotas first
        take(upTo: requestedCritical, from: allCriticals)
        take(upTo: requestedTF, from: allTF)
        take(upTo: requestedImage, from: allImages)

        // Allocate remaining to regulars
        let remainingAfterCategories = max(0, selectedCount - selected.count)
        take(upTo: remainingAfterCategories, from: allRegular)

        // Final backfill from any remaining questions to reach exact count
        if selected.count < selectedCount {
            let remaining = allQuestions.shuffled().filter { !chosenIds.contains($0.id) }
            let need = selectedCount - selected.count
            for q in remaining.prefix(need) {
                selected.append(q)
                chosenIds.insert(q.id)
            }
        }

        self.questions = selected.shuffled()
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

    // MARK: - Difficult (keyword-based)
    private func difficultKeywords() -> [String] {
        ["imprisonment", "exceeding", "kd", "kwd", "fine", "article", "articles", "impound", "punishable", "court"]
    }

    private func isDifficult(_ q: QuizQuestion) -> Bool {
        let keywords = difficultKeywords()
        let lowerText = q.text.lowercased()
        if keywords.contains(where: { lowerText.contains($0) }) { return true }
        let answersText = q.answers.joined(separator: " ").lowercased()
        if keywords.contains(where: { answersText.contains($0) }) { return true }
        return false
    }

    private func difficultQuestions() -> [QuizQuestion] {
        allQuestions.filter { isDifficult($0) }
    }

    private func startDifficultOnlyQuiz() {
        self.questions = difficultQuestions().shuffled()
    }

    private func startDifficultStudy() {
        self.questions = difficultQuestions().shuffled()
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
            if !wrongQuestions.contains(where: { $0.id == q.id }) {
                wrongQuestions.append(q)
            }
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

    // MARK: - Wrong Answers Review
    func startReviewWrongQuestions() {
        guard !wrongQuestions.isEmpty else { return }
        quizMode = .study
        questions = wrongQuestions
        currentIndex = 0
        selectedAnswerIndex = nil
        correctCount = 0
        answeredCriticalWrong = false
        state = .inProgress
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
        let wrongIds = wrongQuestions.map { $0.id }
        let attempt = QuizAttempt(
            id: UUID(),
            date: Date(),
            mode: quizMode,
            total: result.total,
            correct: result.correct,
            passed: result.passed,
            failedCritical: result.failedCritical,
            passingScore: result.passingScore,
            wrongQuestionIds: wrongIds
        )
        history.insert(attempt, at: 0)
        if history.count > 200 { history.removeLast(history.count - 200) }
        saveHistory()
    }

    // Launch study mode showing the wrong questions of a past attempt
    func reviewWrongAnswers(from attempt: QuizAttempt) {
        guard !attempt.wrongQuestionIds.isEmpty else { return }
        let idSet = Set(attempt.wrongQuestionIds)
        let reviewQuestions = allQuestions.filter { idSet.contains($0.id) }
        guard !reviewQuestions.isEmpty else { return }
        withAnimation(.easeInOut(duration: 0.25)) {
            quizMode = .study
            questions = reviewQuestions
            currentIndex = 0
            selectedAnswerIndex = nil
            correctCount = 0
            answeredCriticalWrong = false
            state = .inProgress
        }
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
