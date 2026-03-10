//
//  InterviewCardTests.swift
//  StepUpTests
//
//  Created by 조영현 on 3/4/26.
//

import Testing
import SwiftData
@testable import StepUp

@Suite("InterviewCard Model Tests")
struct InterviewCardTests {

    @Test("Card initialization sets correct values")
    func cardInitialization() {
        let card = InterviewCard(
            question: "Test Question",
            answer: "Test Answer",
            category: .swift
        )

        #expect(card.question == "Test Question")
        #expect(card.answer == "Test Answer")
        #expect(card.category == .swift)
        #expect(card.isBookmarked == false)
        #expect(card.miniProjectType == nil)
        #expect(card.id != UUID())
    }

    @Test("Card with mini project type")
    func cardWithMiniProject() {
        let card = InterviewCard(
            question: "ARC Question",
            answer: "ARC Answer",
            category: .memory,
            miniProjectType: .arc
        )

        #expect(card.miniProjectType == .arc)
        #expect(card.category == .memory)
    }

    @Test("Bookmark toggle works correctly")
    func bookmarkToggle() {
        let card = InterviewCard(
            question: "Q",
            answer: "A",
            category: .swift
        )

        #expect(card.isBookmarked == false)
        card.isBookmarked = true
        #expect(card.isBookmarked == true)
        card.isBookmarked = false
        #expect(card.isBookmarked == false)
    }

    @Test("Category raw value conversion")
    func categoryRawValue() {
        let card = InterviewCard(
            question: "Q",
            answer: "A",
            category: .concurrency
        )

        #expect(card.categoryRawValue == "동시성")
        #expect(card.category == .concurrency)

        card.category = .networking
        #expect(card.categoryRawValue == "네트워킹")
    }

    @Test("Mini project type raw value conversion")
    func miniProjectTypeRawValue() {
        let card = InterviewCard(
            question: "Q",
            answer: "A",
            category: .uikit,
            miniProjectType: .appLifecycle
        )

        #expect(card.miniProjectTypeRawValue == "App 생명주기")
        #expect(card.miniProjectType == .appLifecycle)

        card.miniProjectType = .gcd
        #expect(card.miniProjectTypeRawValue == "GCD / async-await")
    }

    @Test("CreatedAt is set on initialization")
    func createdAtIsSet() {
        let beforeCreation = Date()
        let card = InterviewCard(
            question: "Q",
            answer: "A",
            category: .swift
        )
        let afterCreation = Date()

        #expect(card.createdAt >= beforeCreation)
        #expect(card.createdAt <= afterCreation)
    }
}
