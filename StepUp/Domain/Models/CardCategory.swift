//
//  CardCategory.swift
//  StepUp
//
//  Created by 조영현 on 3/4/26.
//

import Foundation

enum CardCategory: String, Codable, CaseIterable, Identifiable {
    case swift       = "Swift"
    case uikit       = "UIKit"
    case swiftui     = "SwiftUI"
    case architecture = "아키텍처"
    case concurrency = "동시성"
    case memory      = "메모리"
    case networking  = "네트워킹"

    var id: String { rawValue }

    var iconName: String {
        switch self {
        case .swift: return "swift"
        case .uikit: return "rectangle.on.rectangle"
        case .swiftui: return "square.grid.2x2"
        case .architecture: return "building.2"
        case .concurrency: return "arrow.triangle.branch"
        case .memory: return "memorychip"
        case .networking: return "network"
        }
    }
}
