//
//  StudyView.swift
//  Kuwait Driving Test
//
//  Created by Tarek Chaalan on 8/31/25.
//

import SwiftUI

struct StudyView: View {
    let questions: [QuizQuestion]
    let onExit: () -> Void
    @State private var selectedTab = 0
    @State private var currentIndex = 0
    @State private var showAnswer = false

    private let tabs = ["All", "T/F", "Images", "Critical"]

        private var filteredQuestions: [QuizQuestion] {
        switch selectedTab {
        case 0: return questions
        case 1: return questions.filter { $0.tf }
        case 2: return questions.filter { $0.imageName != nil }
        case 3: return questions.filter { $0.isCritical }
        default: return questions
        }
    }

    private var safeCurrentIndex: Int {
        let maxIndex = max(0, filteredQuestions.count - 1)
        return min(currentIndex, maxIndex)
    }

    var body: some View {
        VStack(spacing: 20) {
            // Tab selector
            Picker("Question Type", selection: $selectedTab) {
                ForEach(0..<tabs.count, id: \.self) { index in
                    Text(tabs[index]).tag(index)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)

            if filteredQuestions.isEmpty {
                VStack(spacing: 16) {
                    Image(systemName: "questionmark.circle")
                        .font(.system(size: 48))
                        .foregroundStyle(.secondary)
                    Text("No questions in this category")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                            // Question counter and controls
            HStack {
                Text("\(safeCurrentIndex + 1) of \(filteredQuestions.count)")
                    .font(.subheadline)
                    .foregroundStyle(.primary)
                Spacer()
                Button("Random") {
                    currentIndex = Int.random(in: 0..<filteredQuestions.count)
                    showAnswer = false
                }
                .font(.subheadline)
                .foregroundStyle(.blue)
            }
            .padding(.horizontal)

                // Flashcard
                VStack(spacing: 20) {
                    // Question text
                    Text(filteredQuestions[safeCurrentIndex].text)
                        .font(.title3.weight(.semibold))
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(AppTheme.cardBackground)
                        .clipShape(RoundedRectangle(cornerRadius: 16))

                    // Image if available
                    if let imageName = filteredQuestions[safeCurrentIndex].imageName,
                       UIImage(named: imageName) != nil {
                        Image(imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                    }

                    // Answer options
                    VStack(spacing: 12) {
                        ForEach(filteredQuestions[safeCurrentIndex].answers.indices, id: \.self) { index in
                            HStack {
                                Text(filteredQuestions[safeCurrentIndex].answers[index])
                                    .font(.body)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                                if showAnswer {
                                    Image(systemName: index == filteredQuestions[safeCurrentIndex].correctIndex ? "checkmark.circle.fill" : "xmark.circle.fill")
                                        .foregroundStyle(index == filteredQuestions[safeCurrentIndex].correctIndex ? .green : .red)
                                        .font(.title2)
                                }
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                                                        .background(showAnswer ?
                                (index == filteredQuestions[currentIndex].correctIndex ? Color.green.opacity(0.2) : Color.red.opacity(0.2)) :
                                AppTheme.secondaryButton)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(showAnswer ?
                                        (index == filteredQuestions[currentIndex].correctIndex ? Color.green : Color.red) :
                                        Color.clear, lineWidth: 1.5)
                            )
                        }
                    }

                                    }
                .padding(.horizontal)
            }

            Spacer()

            // Fixed bottom controls
            VStack(spacing: 16) {
                // Show/Hide Answer Button
                Button {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        showAnswer.toggle()
                    }
                } label: {
                    Label(showAnswer ? "Hide Answer" : "Show Answer",
                          systemImage: showAnswer ? "eye.slash" : "eye")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.ultraThickMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                .buttonStyle(.plain)

                // Navigation buttons
                HStack(spacing: 20) {
                    Button {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            currentIndex = max(0, currentIndex - 1)
                            showAnswer = false
                        }
                    } label: {
                        Label("Previous", systemImage: "chevron.left")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(AppTheme.secondaryButton)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                    .buttonStyle(.plain)
                    .disabled(safeCurrentIndex == 0)

                    Button {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            currentIndex = min(filteredQuestions.count - 1, currentIndex + 1)
                            showAnswer = false
                        }
                    } label: {
                        Label("Next", systemImage: "chevron.right")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(AppTheme.secondaryButton)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                    .buttonStyle(.plain)
                    .disabled(safeCurrentIndex == filteredQuestions.count - 1)
                }

                // Exit button
                Button {
                    onExit()
                } label: {
                    Label("Exit Study Mode", systemImage: "xmark.circle.fill")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(AppTheme.dangerButton)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal)
        }
        .navigationTitle("Study Mode")
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: selectedTab) { oldValue, newValue in
            currentIndex = 0
            showAnswer = false
        }
        .onAppear {
            // Ensure currentIndex is valid when view appears
            if currentIndex >= filteredQuestions.count {
                currentIndex = 0
            }
        }
    }
}
