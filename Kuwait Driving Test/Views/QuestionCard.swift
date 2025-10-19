//
//  QuestionCard.swift
//  Kuwait Driving Test
//
//  Created by Tarek Chaalan on 8/31/25.
//

import SwiftUI

struct QuestionCard: View {
    let question: QuizQuestion
    let selectedIndex: Int?
    let onSelect: (Int) -> Void
    var isPinned: Bool = false
    var onTogglePin: ((QuizQuestion) -> Void)? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 8) {
                if question.isCritical {
                    Label("Critical Question", systemImage: "exclamationmark.triangle.fill")
                        .foregroundStyle(.yellow)
                        .font(.footnote.weight(.semibold))
                        .padding(6)
                        .background(Color.yellow.opacity(0.15))
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                        .accessibilityHint("Wrong answer causes instant fail")
                }
                Spacer()
            }

            HStack(alignment: .top, spacing: 8) {
                Text(question.text)
                    .font(.title3.weight(.semibold))
                    .accessibilityAddTraits(.isHeader)
                    .fixedSize(horizontal: false, vertical: true)
                    .minimumScaleFactor(0.5)
                    .lineLimit(nil)
                    .allowsTightening(true)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                if let onTogglePin {
                    Button {
                        onTogglePin(question)
                    } label: {
                        Image(systemName: isPinned ? "pin.fill" : "pin")
                            .foregroundStyle(isPinned ? .orange : .secondary)
                            .accessibilityLabel(isPinned ? "Unsave" : "Save")
                    }
                    .buttonStyle(.plain)
                }
            }

            if let img = question.imageName, UIImage(named: img) != nil {
                Image(img)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 170)
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                    .overlay(RoundedRectangle(cornerRadius: 14).stroke(.thinMaterial))
            }

            VStack(spacing: 10) {
                ForEach(question.answers.indices, id: \.self) { idx in
                    AnswerRow(
                        text: question.answers[idx],
                        isSelected: selectedIndex == idx,
                        isCorrectPreview: false
                    )
                    .onTapGesture { onSelect(idx) }
                    .accessibilityAddTraits(selectedIndex == idx ? .isSelected : [])
                }
            }
        }
        .appCard()
    }
}

private struct AnswerRow: View {
    let text: String
    let isSelected: Bool
    let isCorrectPreview: Bool

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                .imageScale(.large)
            Text(text)
                .font(.body)
                .multilineTextAlignment(.leading)
                .minimumScaleFactor(0.8) // Allow answer text to shrink to 80% of original size
                .lineLimit(.max) // unlimited lines
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(isSelected ? Color.accentColor.opacity(0.18) : Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isSelected ? Color.accentColor : Color.clear, lineWidth: 1.5)
        )
    }
}
