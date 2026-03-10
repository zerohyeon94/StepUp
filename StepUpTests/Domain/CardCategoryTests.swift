//
//  CardCategoryTests.swift
//  StepUpTests
//
//  Created by 조영현 on 3/4/26.
//

import Testing
@testable import StepUp

@Suite("CardCategory Tests")
struct CardCategoryTests {

    @Test("All categories have Korean raw values")
    func allCategoriesHaveRawValues() {
        let expectedValues = [
            "Swift", "UIKit", "SwiftUI", "아키텍처",
            "동시성", "메모리", "네트워킹"
        ]

        for category in CardCategory.allCases {
            #expect(!category.rawValue.isEmpty)
            #expect(expectedValues.contains(category.rawValue))
        }
    }

    @Test("All categories have SF Symbol icon names")
    func allCategoriesHaveIconNames() {
        for category in CardCategory.allCases {
            #expect(!category.iconName.isEmpty)
        }
    }

    @Test("Category count is correct")
    func categoryCount() {
        #expect(CardCategory.allCases.count == 7)
    }

    @Test("Categories are Identifiable")
    func categoriesAreIdentifiable() {
        let swift = CardCategory.swift
        let uikit = CardCategory.uikit

        #expect(swift.id == "Swift")
        #expect(uikit.id == "UIKit")
        #expect(swift.id != uikit.id)
    }

    @Test("Categories are Codable")
    func categoriesAreCodable() throws {
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()

        let original = CardCategory.architecture
        let data = try encoder.encode(original)
        let decoded = try decoder.decode(CardCategory.self, from: data)

        #expect(original == decoded)
    }

    @Test("Icon names are valid SF Symbols")
    func iconNamesMapping() {
        #expect(CardCategory.swift.iconName == "swift")
        #expect(CardCategory.uikit.iconName == "rectangle.on.rectangle")
        #expect(CardCategory.swiftui.iconName == "square.grid.2x2")
        #expect(CardCategory.architecture.iconName == "building.2")
        #expect(CardCategory.concurrency.iconName == "arrow.triangle.branch")
        #expect(CardCategory.memory.iconName == "memorychip")
        #expect(CardCategory.networking.iconName == "network")
    }
}
