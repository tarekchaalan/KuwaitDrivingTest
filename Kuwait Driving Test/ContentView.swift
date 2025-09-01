//
//  ContentView.swift
//  Kuwait Driving Test
//
//  Created by Tarek Chaalan on 8/31/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm = QuizViewModel()
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        ZStack {
            AppTheme.gradient.ignoresSafeArea()

            switch vm.state {
            case .idle:
                startScreen
            case .inProgress:
                QuizView(vm: vm)
            case .finished(let result):
                ResultView(result: result, onRestart: { vm.restart() }, onRetake: { vm.startQuiz() })
            }
        }
        .preferredColorScheme(.dark) // force dark theme
    }

    private var startScreen: some View {
        VStack(spacing: 24) {
            VStack(spacing: 8) {
                Image(systemName: "car.fill")
                    .font(.system(size: 44, weight: .bold))
                    .accessibilityHidden(true)
                Text("Kuwait Driving Test")
                    .font(.largeTitle.bold())
                    .multilineTextAlignment(.center)
                Text("Practice with real-style questions.\nCritical questions cause instant fail.")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
            }
            .padding(.horizontal)

            VStack(spacing: 16) {
                Text("Number of Questions: \(vm.selectedCount)")
                    .font(.headline)
                Slider(value: Binding(
                    get: { Double(vm.selectedCount) },
                    set: { vm.setQuestionCount(Int($0)) }
                ), in: Double(vm.minQuestions)...Double(vm.maxQuestions), step: 5)
                .accessibilityLabel("Number of Questions")
                .padding(.horizontal)

                Button {
                    vm.setQuizMode(.standard)
                    vm.startQuiz()
                } label: {
                    Label("Start Standard Quiz", systemImage: "play.fill")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.ultraThickMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                }
                .buttonStyle(.plain)
                .accessibilityHint("Begins a standard quiz with balanced question distribution")
            }
            .appCard()
            .padding(.horizontal)

            // Specialized Quiz Modes
            VStack(spacing: 12) {
                Text("Specialized Quiz Modes")
                    .font(.headline)
                    .foregroundStyle(.secondary)

                                // First 4 modes in 2x2 grid
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 12) {
                    Button {
                        vm.setQuizMode(.regularOnly)
                        vm.startQuiz()
                    } label: {
                        VStack(spacing: 8) {
                            Image(systemName: "doc.text.fill")
                                .font(.title2)
                                .foregroundStyle(.orange)
                            Text("Regular Only")
                                .font(.subheadline.weight(.semibold))
                                .multilineTextAlignment(.center)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(AppTheme.cardBackground)
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    }
                    .buttonStyle(.plain)

                    Button {
                        vm.setQuizMode(.trueFalseOnly)
                        vm.startQuiz()
                    } label: {
                        VStack(spacing: 8) {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.title2)
                                .foregroundStyle(.green)
                            Text("True/False Only")
                                .font(.subheadline.weight(.semibold))
                                .multilineTextAlignment(.center)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(AppTheme.cardBackground)
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    }
                    .buttonStyle(.plain)

                    Button {
                        vm.setQuizMode(.imageOnly)
                        vm.startQuiz()
                    } label: {
                        VStack(spacing: 8) {
                            Image(systemName: "photo.fill")
                                .font(.title2)
                                .foregroundStyle(.blue)
                            Text("Images Only")
                                .font(.subheadline.weight(.semibold))
                                .multilineTextAlignment(.center)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(AppTheme.cardBackground)
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    }
                    .buttonStyle(.plain)

                    Button {
                        vm.setQuizMode(.criticalOnly)
                        vm.startQuiz()
                    } label: {
                        VStack(spacing: 8) {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .font(.title2)
                                .foregroundStyle(.yellow)
                            Text("Critical Only")
                                .font(.subheadline.weight(.semibold))
                                .multilineTextAlignment(.center)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(AppTheme.cardBackground)
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    }
                    .buttonStyle(.plain)
                }

                // Study Mode as wider button below
                Button {
                    vm.setQuizMode(.study)
                    vm.startQuiz()
                } label: {
                    VStack(spacing: 8) {
                        Image(systemName: "book.fill")
                            .font(.title2)
                            .foregroundStyle(.purple)
                        Text("Study Mode")
                            .font(.subheadline.weight(.semibold))
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(AppTheme.cardBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                }
                .buttonStyle(.plain)
            }
            .appCard()
            .padding(.horizontal)

            Spacer(minLength: 20)
        }
        .padding(.top, 40)
    }
}

#Preview {
    ContentView()
}
