import SwiftUI

struct SavedHeaderTabs: View {
    @ObservedObject var vm: QuizViewModel
    @Binding var selected: Int // 0 = Study-like, 1 = Quiz

    var body: some View {
        VStack(spacing: 8) {
            Picker("Mode", selection: $selected) {
                Text(vm.isArabic ? "مذاكرة" : "Study").tag(0)
                Text(vm.isArabic ? "اختبار" : "Quiz").tag(1)
            }
            .pickerStyle(.segmented)
            .onChange(of: selected) { oldValue, newValue in
                if newValue == 1 {
                    vm.reshuffleSavedQuestionsForQuiz()
                }
            }

            if selected == 0 {
                // Study-like header: show simple count
                HStack {
                    Text(vm.isArabic ? "المحفوظ: \(vm.questions.count)" : "Saved: \(vm.questions.count)")
                        .font(.headline)
                    Spacer()
                }
                .padding(16)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
            } else {
                // Use regular quiz header for progress when in Quiz tab
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(vm.isArabic ? "سؤال \(vm.currentIndex + 1) من \(vm.questions.count)" : "Question \(vm.currentIndex + 1) of \(vm.questions.count)")
                            .font(.headline)
                        ProgressView(value: vm.progress)
                            .tint(.white)
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text(vm.isArabic ? "النتيجة" : "Score")
                            .font(.caption).foregroundStyle(.secondary)
                        Text("\(vm.correctCount)")
                            .font(.headline)
                    }
                }
                .padding(16)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
            }
        }
    }
}


