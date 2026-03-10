//
//  LearningTopic.swift
//  StepUp
//

import SwiftUI

struct LearningSection: Identifiable, Hashable {
    let id: UUID
    let title: String
    let content: String
    let codeExample: String?

    init(id: UUID = UUID(), title: String, content: String, codeExample: String? = nil) {
        self.id = id
        self.title = title
        self.content = content
        self.codeExample = codeExample
    }
}

struct LearningTopic: Identifiable, Hashable {
    let id: UUID
    let order: Int
    let title: String
    let subtitle: String
    let iconName: String
    let color: Color
    let sections: [LearningSection]

    init(
        id: UUID = UUID(),
        order: Int,
        title: String,
        subtitle: String,
        iconName: String,
        color: Color,
        sections: [LearningSection]
    ) {
        self.id = id
        self.order = order
        self.title = title
        self.subtitle = subtitle
        self.iconName = iconName
        self.color = color
        self.sections = sections
    }
}
