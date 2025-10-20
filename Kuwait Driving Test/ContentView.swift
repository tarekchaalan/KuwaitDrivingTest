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
//    @State private var confettiTick = 0 // CONFETTI TEST
    @State private var sliderValue: Double = 20
    @State private var showHistory: Bool = false

    var body: some View {
        ZStack {
            AppTheme.gradient.ignoresSafeArea()

            switch vm.state {
            case .idle:
                startScreen
            case .inProgress:
                QuizView(vm: vm)
            case .finished(let result):
                ResultView(
                    result: result,
                    onRestart: { vm.restart() },
                    onRetake: { vm.startQuiz() },
                    onReviewWrong: { vm.startReviewWrongQuestions() }
                )
            }
        }
        .preferredColorScheme(.dark) // force dark theme
        .onAppear {
            sliderValue = Double(vm.selectedCount)
        }
    }

    private var startScreen: some View {
        VStack(spacing: 24) {
            // Top bar with history
            HStack {
                Spacer()
                Button {
                    showHistory = true
                } label: {
                    Image(systemName: "chart.bar.xaxis")
                        .font(.title3)
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal)
            .padding(.top, 8)
            VStack(spacing: 8) {
                Text("Kuwait Driving Test")
                    .font(.largeTitle.bold())
                    .multilineTextAlignment(.center)
                Text("Practice with real MOI questions.\nCritical questions cause instant fail.")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
            }
            .padding(.horizontal)

            VStack(spacing: 16) {
                Text("Number of Questions: \(Int(sliderValue))")
                    .font(.headline)
                Slider(
                    value: $sliderValue,
                    in: Double(vm.minQuestions)...Double(vm.maxQuestions),
                    step: 5,
                    onEditingChanged: { editing in
                        if !editing {
                            vm.setQuestionCount(Int(sliderValue))
                        }
                    }
                )
                .accessibilityLabel("Number of Questions")
                .padding(.horizontal)

                Button {
                    vm.setQuestionCount(Int(sliderValue))
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

//            Button("Test Confetti") { confettiTick += 1 } // CONFETTI TEST

            // Specialized Quiz Modes
            VStack(spacing: 12) {
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 12) {
                    Button {
                        vm.setQuestionCount(Int(sliderValue))
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

                    .buttonStyle(.plain)
                    Button {
                        vm.setQuestionCount(Int(sliderValue))
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
                        vm.setQuestionCount(Int(sliderValue))
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
                        vm.setQuestionCount(Int(sliderValue))
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

                HStack(spacing: 12) {
                    Button {
                        vm.setQuizMode(.difficultStudy)
                        vm.startQuiz()
                    } label: {
                        VStack(spacing: 8) {
                            Image(systemName: "book.fill")
                                .font(.title2)
                                .foregroundStyle(.pink)
                            Text("Difficult Study")
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
                        vm.setQuestionCount(Int(sliderValue))
                        vm.setQuizMode(.difficultOnly)
                        vm.startQuiz()
                    } label: {
                        VStack(spacing: 8) {
                            Image(systemName: "exclamationmark.circle.fill")
                                .font(.title2)
                                .foregroundStyle(.pink)
                            Text("Difficult Quiz")
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

                // Study and Saved buttons side-by-side
                HStack(spacing: 12) {
                    Button {
                        vm.setQuestionCount(Int(sliderValue))
                        vm.setQuizMode(.study)
                        vm.startQuiz()
                    } label: {
                        VStack(spacing: 8) {
                            Image(systemName: "book.fill")
                                .font(.title2)
                                .foregroundStyle(.purple)
                            Text("Study")
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
                        vm.setQuestionCount(Int(sliderValue))
                        vm.setQuizMode(.savedOnly)
                        vm.startQuiz()
                    } label: {
                        VStack(spacing: 8) {
                            Image(systemName: "pin.fill")
                                .font(.title2)
                                .foregroundStyle(.orange)
                            Text("Saved")
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
            }
            .appCard()
            .padding(.horizontal)

            Spacer(minLength: 20)
        }
        .padding(.top, 20)
        .sheet(isPresented: $showHistory) {
            HistoryView(vm: vm, onClose: { showHistory = false })
        }
//        .overlay(alignment: .top) { // CONFETTI TEST
//            if confettiTick > 0 { // CONFETTI TEST
//                ConfettiView(isPerfect: false) // CONFETTI TEST
//                    .id(confettiTick)
//            } // CONFETTI TEST
//        } // CONFETTI TEST
    }
}

#Preview {
    ContentView()
}
