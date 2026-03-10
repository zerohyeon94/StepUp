//
//  AppColors.swift
//  StepUp
//
//  Created by 조영현 on 3/4/26.
//

import SwiftUI

enum AppColors {
    static let primary = Color.blue
    static let secondary = Color.gray
    static let accent = Color.orange
    static let background = Color(.systemGroupedBackground)
    static let cardBackground = Color(.systemBackground)

    static func categoryColor(_ category: CardCategory) -> Color {
        switch category {
        case .swift: return .orange
        case .uikit: return .blue
        case .swiftui: return .purple
        case .architecture: return .green
        case .concurrency: return .red
        case .memory: return .teal
        case .networking: return .indigo
        }
    }
}
