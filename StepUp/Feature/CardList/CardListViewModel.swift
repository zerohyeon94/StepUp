//
//  CardListViewModel.swift
//  StepUp
//
//  Created by 조영현 on 3/4/26.
//

import Foundation
import SwiftData
import Observation

@Observable
@MainActor
final class CardListViewModel {
    private(set) var cards: [InterviewCard] = []
    private(set) var isLoading = false
    private(set) var error: Error?

    var selectedCategory: CardCategory?
    var searchText = ""
    var showBookmarkedOnly = false

    var filteredCards: [InterviewCard] {
        var result = cards

        if let category = selectedCategory {
            result = result.filter { $0.category == category }
        }

        if showBookmarkedOnly {
            result = result.filter { $0.isBookmarked }
        }

        if !searchText.isEmpty {
            result = result.filter {
                $0.question.localizedCaseInsensitiveContains(searchText) ||
                $0.answer.localizedCaseInsensitiveContains(searchText)
            }
        }

        return result
    }

    private let modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    func loadCards() async {
        isLoading = true
        error = nil

        do {
            var descriptor = FetchDescriptor<InterviewCard>(
                predicate: #Predicate<InterviewCard> { $0.isDeleted == false },
                sortBy: [SortDescriptor(\.createdAt, order: .reverse)]
            )
            descriptor.fetchLimit = nil
            cards = try modelContext.fetch(descriptor)
        } catch {
            self.error = error
        }

        isLoading = false
    }

    func toggleBookmark(for card: InterviewCard) {
        card.isBookmarked.toggle()
        try? modelContext.save()
    }

    func deleteCard(_ card: InterviewCard) {
        card.isDeleted = true
        card.deletedAt = Date()
        try? modelContext.save()
        cards.removeAll { $0.id == card.id }
    }
}
