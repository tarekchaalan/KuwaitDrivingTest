import SwiftUI

struct HistoryView: View {
    @ObservedObject var vm: QuizViewModel
    let onClose: () -> Void

    private var attempts: [QuizAttempt] { vm.history }

    private var totalAttempts: Int { attempts.count }
    private var passRate: Double {
        guard totalAttempts > 0 else { return 0 }
        let passes = attempts.filter { $0.passed && !$0.failedCritical }.count
        return Double(passes) / Double(totalAttempts)
    }
    private var averageScore: Double {
        guard totalAttempts > 0 else { return 0 }
        let totalCorrect = attempts.reduce(0) { $0 + $1.correct }
        let totalQuestions = attempts.reduce(0) { $0 + $1.total }
        return totalQuestions == 0 ? 0 : Double(totalCorrect) / Double(totalQuestions)
    }

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Button(action: onClose) {
                    Label("Back", systemImage: "chevron.left")
                }
                .buttonStyle(.plain)
                Spacer()
                Text("History & Analytics")
                    .font(.headline)
                Spacer()
                Spacer().frame(width: 44) // balance
            }

            // Summary cards
            HStack(spacing: 12) {
                summaryCard(title: "Attempts", value: "\(totalAttempts)")
                summaryCard(title: "Pass Rate", value: String(format: "%.0f%%", passRate * 100))
                summaryCard(title: "Avg Score", value: String(format: "%.0f%%", averageScore * 100))
            }

            if attempts.isEmpty {
                VStack(spacing: 12) {
                    Image(systemName: "chart.bar.doc.horizontal")
                        .font(.system(size: 42))
                        .foregroundStyle(.secondary)
                    Text("No attempts yet")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                List {
                    ForEach(attempts) { a in
                        HStack(spacing: 12) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(a.mode.rawValue)
                                    .font(.subheadline.weight(.semibold))
                                Text(a.date.formatted(date: .abbreviated, time: .shortened))
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            Spacer()
                            VStack(alignment: .trailing, spacing: 4) {
                                Text("\(a.correct)/\(a.total)")
                                    .font(.subheadline)
                                HStack(spacing: 6) {
                                    if a.failedCritical {
                                        Label("Critical Fail", systemImage: "exclamationmark.triangle.fill")
                                            .foregroundStyle(.yellow)
                                            .font(.caption)
                                    }
                                    Text(a.passed ? "Passed" : "Failed")
                                        .font(.caption.weight(.semibold))
                                        .foregroundStyle(a.passed && !a.failedCritical ? .green : .red)
                                }
                            }
                        }
                    }
                }
                .listStyle(.plain)
            }
        }
        .padding()
    }

    private func summaryCard(title: String, value: String) -> some View {
        VStack(spacing: 6) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
            Text(value)
                .font(.headline)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(AppTheme.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}


