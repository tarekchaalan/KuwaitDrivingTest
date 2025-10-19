//
//  QuizView.swift
//  Kuwait Driving Test
//
//  Created by Tarek Chaalan on 8/31/25.
//

import SwiftUI

struct QuizView: View {
    @ObservedObject var vm: QuizViewModel
    @State private var showExitAlert = false
    @State private var showHistory = false
    @State private var savedSelectedTab = 1 // 0 study-like, 1 quiz
    @State private var savedStudyShowAnswer = false
    @State private var savedStudyTappedIndex: Int? = nil

    var body: some View {
        if vm.quizMode == .study {
            StudyView(questions: vm.questions, onExit: { vm.exitStudyMode() }, vm: vm)
                .transition(.opacity.combined(with: .scale))
        } else {
            VStack(spacing: 16) {
                // Back button only for Saved mode when empty
                if vm.quizMode == .savedOnly && vm.questions.isEmpty {
                    HStack {
                        Button {
                            // Use same confirmation flow as Exit
                            let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
                            impactFeedback.impactOccurred()
                            showExitAlert = true
                        } label: {
                            Label("Back", systemImage: "chevron.left")
                                .font(.headline)
                        }
                        .buttonStyle(.plain)
                        Spacer()
                    }
                }

                // Saved mode: provide tabs for Study vs Quiz
                if vm.quizMode == .savedOnly {
                    SavedHeaderTabs(vm: vm, selected: $savedSelectedTab)
                } else {
                    header
                }

                if vm.quizMode == .savedOnly && vm.questions.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "pin.slash")
                            .font(.system(size: 40))
                            .foregroundStyle(.secondary)
                        Text("No saved questions yet")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if vm.quizMode == .savedOnly && savedSelectedTab == 0 {
                    // STUDY-like view for Saved
                    let q = vm.questions[vm.currentIndex]
                    ScrollView { savedStudyContent(q).frame(maxWidth: .infinity) }
                    savedStudyControls()
                } else if let q = vm.currentQuestion {
                    ScrollView {
                        QuestionCard(
                            question: q,
                            selectedIndex: vm.selectedAnswerIndex,
                            onSelect: vm.selectAnswer(_:),
                            isPinned: vm.isPinned(q),
                            onTogglePin: { vm.togglePin($0) }
                        )
                    }
                    Spacer(minLength: 8)
                    if !(vm.quizMode == .savedOnly && vm.questions.isEmpty) {
                        submitBar
                    }
                } else {
                    ProgressView()
                }
            }
            .padding()
            .transition(.opacity.combined(with: .scale))
            .alert("Exit Quiz?", isPresented: $showExitAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Exit", role: .destructive) {
                    vm.restart()
                }
            } message: {
                Text("Are you sure you want to exit? All progress will be lost.")
            }
        }
    }

    private var header: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text("Question \(vm.currentIndex + 1) of \(vm.questions.count)")
                    .font(.headline)
                ProgressView(value: vm.progress)
                    .tint(.white)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("Score")
                    .font(.caption).foregroundStyle(.secondary)
                Text("\(vm.correctCount)")
                    .font(.headline)
            }
        }
        .padding(16)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Progress. Question \(vm.currentIndex + 1) of \(vm.questions.count). Score \(vm.correctCount)")
    }

    // MARK: - Saved Study Helpers

    @ViewBuilder
    private func savedStudyContent(_ q: QuizQuestion) -> some View {
        VStack(spacing: 16) {
            HStack(alignment: .top, spacing: 8) {
                Text(q.text)
                    .font(.title3.weight(.semibold))
                    .fixedSize(horizontal: false, vertical: true)
                    .lineLimit(nil)
                    .minimumScaleFactor(0.5)
                    .allowsTightening(true)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                let pinned = vm.isPinned(q)
                Button { vm.togglePin(q) } label: {
                    Image(systemName: pinned ? "pin.fill" : "pin")
                        .foregroundStyle(pinned ? .orange : .secondary)
                }
                .buttonStyle(.plain)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(AppTheme.cardBackground)
            .clipShape(RoundedRectangle(cornerRadius: 16))

            if let img = q.imageName, UIImage(named: img) != nil {
                Image(img)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 170)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
            }

            VStack(spacing: 12) {
                ForEach(q.answers.indices, id: \.self) { idx in
                    let isCorrect = (idx == q.correctIndex)
                    let isTappedWrong = (savedStudyTappedIndex == idx && !isCorrect)
                    HStack {
                        Text(q.answers[idx])
                            .font(.body)
                            .multilineTextAlignment(.leading)
                        Spacer()
                        if savedStudyShowAnswer {
                            if isCorrect {
                                Image(systemName: "checkmark.circle.fill").foregroundStyle(.green).font(.title2)
                            } else if isTappedWrong {
                                Image(systemName: "xmark.circle.fill").foregroundStyle(.red).font(.title2)
                            }
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if savedStudyTappedIndex == idx && savedStudyShowAnswer { return }
                        withAnimation(.easeInOut(duration: 0.2)) {
                            savedStudyTappedIndex = idx
                            if !savedStudyShowAnswer { savedStudyShowAnswer = true }
                        }
                    }
                    .background(savedStudyBackground(isCorrect: isCorrect, isTappedWrong: isTappedWrong))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(savedStudyStroke(isCorrect: isCorrect, isTappedWrong: isTappedWrong), lineWidth: 1.5)
                    )
                }
            }
        }
    }

    @ViewBuilder
    private func savedStudyControls() -> some View {
        VStack(spacing: 16) {
            Button { toggleSavedStudyAnswer() } label: {
                Label(savedStudyShowAnswer ? "Hide Answer" : "Show Answer",
                      systemImage: savedStudyShowAnswer ? "eye.slash" : "eye")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.ultraThickMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            .buttonStyle(.plain)

            HStack(spacing: 20) {
                Button { savedStudyPrev() } label: {
                    Label("Previous", systemImage: "chevron.left")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(AppTheme.secondaryButton)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                .buttonStyle(.plain)
                .disabled(vm.currentIndex == 0)

                Button { savedStudyNext() } label: {
                    Label("Next", systemImage: "chevron.right")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(AppTheme.secondaryButton)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                .buttonStyle(.plain)
                .disabled(vm.currentIndex >= vm.questions.count - 1)
            }

            Button { vm.restart() } label: {
                Label("Exit", systemImage: "xmark.circle.fill")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(AppTheme.dangerButton)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            .buttonStyle(.plain)
        }
    }

    private func savedStudyBackground(isCorrect: Bool, isTappedWrong: Bool) -> Color {
        guard savedStudyShowAnswer else { return AppTheme.secondaryButton }
        if isCorrect { return Color.green.opacity(0.2) }
        return isTappedWrong ? Color.red.opacity(0.2) : AppTheme.secondaryButton
    }

    private func savedStudyStroke(isCorrect: Bool, isTappedWrong: Bool) -> Color {
        guard savedStudyShowAnswer else { return Color.clear }
        if isCorrect { return Color.green }
        return isTappedWrong ? Color.red : Color.clear
    }

    private func toggleSavedStudyAnswer() {
        withAnimation(.easeInOut(duration: 0.3)) {
            savedStudyShowAnswer.toggle()
            if !savedStudyShowAnswer { savedStudyTappedIndex = nil }
        }
    }

    private func savedStudyPrev() {
        withAnimation(.easeInOut(duration: 0.3)) {
            vm.goToPreviousQuestion()
            savedStudyShowAnswer = false
            savedStudyTappedIndex = nil
        }
    }

    private func savedStudyNext() {
        withAnimation(.easeInOut(duration: 0.3)) {
            vm.goToNextQuestion()
            savedStudyShowAnswer = false
            savedStudyTappedIndex = nil
        }
    }

    private var submitBar: some View {
        HStack(spacing: 12) {
            Button(role: .cancel) {
                // Trigger haptic feedback and show confirmation alert
                let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
                impactFeedback.impactOccurred()
                showExitAlert = true
            } label: {
                Label("Exit", systemImage: "xmark")
                    .frame(maxWidth: .infinity)
                    .padding()
            }
            .background(AppTheme.dangerButton)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))

            Button {
                vm.submitAndAdvance()
            } label: {
                Label(vm.currentIndex == vm.questions.count - 1 ? "Finish" : "Next",
                      systemImage: "arrow.right")
                    .frame(maxWidth: .infinity)
                    .padding()
            }
            .disabled(vm.selectedAnswerIndex == nil)
            .background(vm.selectedAnswerIndex == nil ? Color.gray.opacity(0.3) : Color.accentColor)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .accessibilityHint("Submit selected answer and move to next")
        }
        .font(.headline)
    }
}
