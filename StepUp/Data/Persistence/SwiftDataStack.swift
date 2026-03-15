//
//  SwiftDataStack.swift
//  StepUp
//
//  Created by 조영현 on 3/4/26.
//

import SwiftData
import Foundation

enum SwiftDataStack {
    static func createModelContainer(inMemory: Bool = false) -> ModelContainer {
        let schema = Schema([InterviewCard.self])
        let configuration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: inMemory
        )

        do {
            return try ModelContainer(for: schema, configurations: [configuration])
        } catch {
            fatalError("Failed to create ModelContainer: \(error)")
        }
    }

    @MainActor
    static func syncSeedData(context: ModelContext) {
        let seedCards = SeedCardData.allCards

        let descriptor = FetchDescriptor<InterviewCard>()
        let existingCards = (try? context.fetch(descriptor)) ?? []
        let existingByStableId = Dictionary(
            uniqueKeysWithValues: existingCards.compactMap { card in
                card.stableId.map { ($0, card) }
            }
        )

        for seed in seedCards {
            if let existing = existingByStableId[seed.stableId] {
                if existing.question != seed.question
                    || existing.answer != seed.answer
                    || existing.categoryRawValue != seed.category.rawValue {
                    existing.question = seed.question
                    existing.answer = seed.answer
                    existing.category = seed.category
                    existing.miniProjectType = seed.miniProjectType
                }
            } else {
                let card = InterviewCard(
                    question: seed.question,
                    answer: seed.answer,
                    category: seed.category,
                    miniProjectType: seed.miniProjectType
                )
                card.stableId = seed.stableId
                context.insert(card)
            }
        }
    }
}
