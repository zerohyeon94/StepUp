//
//  CardRepository.swift
//  StepUp
//
//  Created by 조영현 on 3/4/26.
//

import Foundation
import SwiftData

protocol CardRepositoryProtocol {
    func fetchAll() async throws -> [InterviewCard]
    func fetchByCategory(_ category: CardCategory) async throws -> [InterviewCard]
    func fetchBookmarked() async throws -> [InterviewCard]
    func save(_ card: InterviewCard) async throws
    func delete(_ card: InterviewCard) async throws
    func toggleBookmark(_ card: InterviewCard) async throws
}

final class CardRepository: CardRepositoryProtocol {
    private let modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    func fetchAll() async throws -> [InterviewCard] {
        let descriptor = FetchDescriptor<InterviewCard>(
            predicate: #Predicate<InterviewCard> { $0.isDeleted == false },
            sortBy: [SortDescriptor(\.createdAt, order: .reverse)]
        )
        return try modelContext.fetch(descriptor)
    }

    func fetchByCategory(_ category: CardCategory) async throws -> [InterviewCard] {
        let rawValue = category.rawValue
        let descriptor = FetchDescriptor<InterviewCard>(
            predicate: #Predicate<InterviewCard> {
                $0.isDeleted == false && $0.categoryRawValue == rawValue
            },
            sortBy: [SortDescriptor(\.createdAt, order: .reverse)]
        )
        return try modelContext.fetch(descriptor)
    }

    func fetchBookmarked() async throws -> [InterviewCard] {
        let descriptor = FetchDescriptor<InterviewCard>(
            predicate: #Predicate<InterviewCard> {
                $0.isDeleted == false && $0.isBookmarked == true
            },
            sortBy: [SortDescriptor(\.createdAt, order: .reverse)]
        )
        return try modelContext.fetch(descriptor)
    }

    func save(_ card: InterviewCard) async throws {
        modelContext.insert(card)
        try modelContext.save()
    }

    func delete(_ card: InterviewCard) async throws {
        card.isDeleted = true
        card.deletedAt = Date()
        try modelContext.save()
    }

    func toggleBookmark(_ card: InterviewCard) async throws {
        card.isBookmarked.toggle()
        try modelContext.save()
    }
}
