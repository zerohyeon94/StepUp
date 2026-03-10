//
//  CardDetailViewModel.swift
//  StepUp
//
//  Created by 조영현 on 3/4/26.
//

import SwiftUI
import Foundation
import SwiftData
import Observation

@Observable
@MainActor
final class CardDetailViewModel {
    let card: InterviewCard
    var isFlipped = false

    private let modelContext: ModelContext

    init(card: InterviewCard, modelContext: ModelContext) {
        self.card = card
        self.modelContext = modelContext
    }

    func toggleFlip() {
        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
            isFlipped.toggle()
        }
    }

    func toggleBookmark() {
        card.isBookmarked.toggle()
        try? modelContext.save()
    }

    var hasMiniProject: Bool {
        card.miniProjectType != nil
    }
}
