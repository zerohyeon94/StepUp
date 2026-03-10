//
//  BookmarkCardUseCase.swift
//  StepUp
//
//  Created by 조영현 on 3/4/26.
//

import Foundation
import SwiftData

protocol BookmarkCardUseCaseProtocol {
    func execute(card: InterviewCard, isBookmarked: Bool) async throws
}

final class BookmarkCardUseCase: BookmarkCardUseCaseProtocol {
    private let modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    func execute(card: InterviewCard, isBookmarked: Bool) async throws {
        card.isBookmarked = isBookmarked
        try modelContext.save()
    }
}
