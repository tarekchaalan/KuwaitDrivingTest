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

    var body: some View {
        if vm.quizMode == .study {
            StudyView(questions: vm.questions, onExit: { vm.exitStudyMode() })
                .transition(.opacity.combined(with: .scale))
        } else {
            VStack(spacing: 16) {
                header
                if let q = vm.currentQuestion {
                    QuestionCard(question: q,
                                 selectedIndex: vm.selectedAnswerIndex,
                                 onSelect: vm.selectAnswer(_:))
                    Spacer(minLength: 8)
                    submitBar
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
