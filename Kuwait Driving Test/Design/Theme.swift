//
//  Theme.swift
//  Kuwait Driving Test
//
//  Created by Tarek Chaalan on 8/31/25.
//

import SwiftUI

struct AppTheme {
    // Dark theme gradient
    static let gradient = LinearGradient(
        gradient: Gradient(colors: [Color.black, Color(.systemGray6)]),
        startPoint: .topLeading, endPoint: .bottomTrailing
    )

    // Dark card background
    static let cardBackground = Color(.systemGray6).opacity(0.9)

    // Consistent button colors for dark theme
    static let primaryButton = Color.blue
    static let secondaryButton = Color(.systemGray5)
    static let dangerButton = Color.red
    static let successButton = Color.green

    struct CardStyle: ViewModifier {
        func body(content: Content) -> some View {
            content
                .padding(20)
                .background(AppTheme.cardBackground)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .shadow(color: Color.black.opacity(0.3), radius: 16, x: 0, y: 6)
        }
    }

    static func card() -> some ViewModifier { CardStyle() }
}

extension View {
    func appCard() -> some View { self.modifier(AppTheme.card()) }
}
