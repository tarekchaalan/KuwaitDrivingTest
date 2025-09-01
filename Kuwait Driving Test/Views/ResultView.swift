//
//  ResultView.swift
//  Kuwait Driving Test
//
//  Created by Tarek Chaalan on 8/31/25.
//

import SwiftUI

struct ResultView: View {
    let result: QuizResult
    let onRestart: () -> Void
    let onRetake: () -> Void
    
    var body: some View {
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
                Button {
                    onRestart()
                } label: {
                    Label("Home", systemImage: "house.fill")
                        .frame(maxWidth: .infinity).padding()
                }
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                
                Button {
                    onRetake()
                } label: {
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
        .background(AppTheme.gradient.ignoresSafeArea())
    }
    
    private var header: some View {
        VStack(spacing: 10) {
            if result.failedCritical {
                Image(systemName: "exclamationmark.triangle.fill").font(.system(size: 44))
                Text("Failed — Critical Question Missed")
                    .font(.title2.bold())
                Text("Any critical mistake results in an automatic fail.")
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            } else if result.passed {
                Image(systemName: "checkmark.seal.fill").font(.system(size: 44))
                Text("Passed")
                    .font(.title2.bold())
                Text("Great job! Keep practicing to perfect it.")
                    .foregroundStyle(.secondary)
            } else {
                Image(systemName: "xmark.seal.fill").font(.system(size: 44))
                Text("Not Yet")
                    .font(.title2.bold())
                Text("You can do it—review and try again.")
                    .foregroundStyle(.secondary)
            }
        }
        .foregroundStyle(.white)
        .padding(.horizontal)
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
