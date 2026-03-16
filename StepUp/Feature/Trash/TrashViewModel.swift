//
//  TrashViewModel.swift
//  StepUp
//
//  Created by Claude on 3/15/26.
//

import Foundation
import SwiftData
import Observation

@Observable
@MainActor
final class TrashViewModel {
    private(set) var deletedCards: [InterviewCard] = []
    private(set) var isLoading = false

    var deletedCardCount: Int {
        deletedCards.count
    }

    private let modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    func loadDeletedCards() async {
        isLoading = true

        do {
            let descriptor = FetchDescriptor<InterviewCard>(
                predicate: #Predicate<InterviewCard> { $0.isDeleted == true },
                sortBy: [SortDescriptor(\.deletedAt, order: .reverse)]
            )
            deletedCards = try modelContext.fetch(descriptor)
        } catch {
            deletedCards = []
        }

        isLoading = false
    }

    func restoreCard(_ card: InterviewCard) {
        card.isDeleted = false
        card.deletedAt = nil
        try? modelContext.save()
        deletedCards.removeAll { $0.id == card.id }
        notifyCardsChanged()
    }

    func permanentlyDelete(_ card: InterviewCard) {
        if let stableId = card.stableId {
            SeedCardExclusion.addExcludedId(stableId)
        }
        modelContext.delete(card)
        try? modelContext.save()
        deletedCards.removeAll { $0.id == card.id }
    }

    func restoreAll() {
        for card in deletedCards {
            card.isDeleted = false
            card.deletedAt = nil
        }
        try? modelContext.save()
        deletedCards.removeAll()
        notifyCardsChanged()
    }

    func emptyTrash() {
        for card in deletedCards {
            if let stableId = card.stableId {
                SeedCardExclusion.addExcludedId(stableId)
            }
            modelContext.delete(card)
        }
        try? modelContext.save()
        deletedCards.removeAll()
    }

    private func notifyCardsChanged() {
        NotificationCenter.default.post(name: .cardsDidChange, object: nil)
    }
}

extension Notification.Name {
    static let cardsDidChange = Notification.Name("cardsDidChange")
}
