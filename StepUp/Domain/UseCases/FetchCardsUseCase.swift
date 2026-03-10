//
//  FetchCardsUseCase.swift
//  StepUp
//
//  Created by 조영현 on 3/4/26.
//

import Foundation
import SwiftData

protocol FetchCardsUseCaseProtocol {
    func execute(filter: CardCategory?) async throws -> [InterviewCard]
}

final class FetchCardsUseCase: FetchCardsUseCaseProtocol {
    private let modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    func execute(filter: CardCategory? = nil) async throws -> [InterviewCard] {
        var descriptor = FetchDescriptor<InterviewCard>(
            sortBy: [SortDescriptor(\.createdAt, order: .reverse)]
        )

        if let category = filter {
            let rawValue = category.rawValue
            descriptor.predicate = #Predicate<InterviewCard> { card in
                card.categoryRawValue == rawValue
            }
        }

        return try modelContext.fetch(descriptor)
    }
}
