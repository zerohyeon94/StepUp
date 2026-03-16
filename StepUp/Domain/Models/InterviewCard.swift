//
//  InterviewCard.swift
//  StepUp
//
//  Created by 조영현 on 3/4/26.
//

import Foundation
import SwiftData

@Model
final class InterviewCard {
    var id: UUID
    var stableId: String?
    var question: String
    var answer: String
    @Attribute var categoryRawValue: String
    var isBookmarked: Bool
    var isDeleted: Bool
    var deletedAt: Date?
    @Attribute var miniProjectTypeRawValue: String?
    var createdAt: Date

    var category: CardCategory {
        get { CardCategory(rawValue: categoryRawValue) ?? .swift }
        set { categoryRawValue = newValue.rawValue }
    }

    var miniProjectType: MiniProjectType? {
        get {
            guard let raw = miniProjectTypeRawValue else { return nil }
            return MiniProjectType(rawValue: raw)
        }
        set { miniProjectTypeRawValue = newValue?.rawValue }
    }

    init(
        question: String,
        answer: String,
        category: CardCategory,
        miniProjectType: MiniProjectType? = nil
    ) {
        self.id = UUID()
        self.question = question
        self.answer = answer
        self.categoryRawValue = category.rawValue
        self.isBookmarked = false
        self.isDeleted = false
        self.deletedAt = nil
        self.miniProjectTypeRawValue = miniProjectType?.rawValue
        self.createdAt = Date()
    }
}
