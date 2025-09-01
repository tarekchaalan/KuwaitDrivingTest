import SwiftUI

struct ResultView: View {
    let result: QuizResult
    let onRestart: () -> Void
    let onRetake: () -> Void

    @State private var showConfetti = false
    private var isPerfect: Bool { result.passed && result.correct == result.total }

    var body: some View {
        ZStack {
            AppTheme.gradient.ignoresSafeArea()

            VStack(spacing: 24) {
                header

                VStack(spacing: 14) {
                    metricRow(title: "Score", value: "\(result.correct)/\(result.total)")
                    metricRow(title: "Passing Score", value: "≥ \(result.passingScore)")
                }
                .appCard()
                .padding(.horizontal)

                Spacer()

                HStack(spacing: 12) {
                    Button(action: onRestart) {
                        Label("Home", systemImage: "house.fill")
                            .frame(maxWidth: .infinity).padding()
                    }
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))

                    Button(action: onRetake) {
                        Label("Retake", systemImage: "arrow.clockwise")
                            .frame(maxWidth: .infinity).padding()
                    }
                    .background(Color.accentColor)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                }
                .font(.headline)
                .padding(.horizontal)

                Spacer(minLength: 20)
            }
            .padding(.top, 40)

            if showConfetti {
                ConfettiView(isPerfect: isPerfect)
                    .allowsHitTesting(false)
                    .transition(.opacity)
                    .ignoresSafeArea()
            }
        }
        .onAppear {
            guard result.passed else { return }

            let notif = UINotificationFeedbackGenerator()
            notif.notificationOccurred(.success)
            if isPerfect {
                let impact = UIImpactFeedbackGenerator(style: .heavy)
                impact.impactOccurred(intensity: 0.9)
            }

            withAnimation(.easeInOut(duration: 0.22)) { showConfetti = true }
        }
        .onDisappear {
            showConfetti = false
        }
    }

    private var header: some View {
        VStack(spacing: 10) {
            if result.failedCritical {
                Image(systemName: "exclamationmark.triangle.fill").font(.system(size: 44))
                Text("Failed — Critical Question Missed").font(.title2.bold())
                Text("Any critical mistake results in an automatic fail.")
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            } else if isPerfect {
                Image(systemName: "crown.fill").font(.system(size: 48))
                Text("Perfect Score!").font(.title2.bold())
                Text("Flawless — every answer correct.")
                    .foregroundStyle(.secondary)
            } else if result.passed {
                Image(systemName: "checkmark.seal.fill").font(.system(size: 44))
                Text("Passed").font(.title2.bold())
                Text("Great job! Keep practicing to perfect it.")
                    .foregroundStyle(.secondary)
            } else {
                Image(systemName: "xmark.seal.fill").font(.system(size: 44))
                Text("Not Yet").font(.title2.bold())
                Text("You can do it—review and try again.")
                    .foregroundStyle(.secondary)
            }
        }
        .foregroundStyle(.white)
        .padding(.horizontal)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(
            result.failedCritical ? "Failed. Critical question missed."
            : isPerfect        ? "Perfect score."
            : result.passed    ? "Passed."
                               : "Not yet passed."
        )
    }

    private func metricRow(title: String, value: String) -> some View {
        HStack {
            Text(title)
            Spacer()
            Text(value).font(.headline)
        }
        .padding(.vertical, 6)
    }
}
