//
//  MiniProjectTypeTests.swift
//  StepUpTests
//
//  Created by 조영현 on 3/4/26.
//

import Testing
@testable import StepUp

@Suite("MiniProjectType Tests")
struct MiniProjectTypeTests {

    @Test("All mini project types have raw values")
    func allTypesHaveRawValues() {
        let expectedValues = [
            "App 생명주기", "ARC", "GCD / async-await", "RunLoop"
        ]

        for type in MiniProjectType.allCases {
            #expect(!type.rawValue.isEmpty)
            #expect(expectedValues.contains(type.rawValue))
        }
    }

    @Test("All mini project types have descriptions")
    func allTypesHaveDescriptions() {
        for type in MiniProjectType.allCases {
            #expect(!type.description.isEmpty)
            #expect(type.description.count > 10) // Descriptions should be meaningful
        }
    }

    @Test("Mini project type count is correct")
    func typeCount() {
        #expect(MiniProjectType.allCases.count == 4)
    }

    @Test("Types are Identifiable")
    func typesAreIdentifiable() {
        let appLifecycle = MiniProjectType.appLifecycle
        let arc = MiniProjectType.arc

        #expect(appLifecycle.id == "App 생명주기")
        #expect(arc.id == "ARC")
        #expect(appLifecycle.id != arc.id)
    }

    @Test("Types are Codable")
    func typesAreCodable() throws {
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()

        let original = MiniProjectType.gcd
        let data = try encoder.encode(original)
        let decoded = try decoder.decode(MiniProjectType.self, from: data)

        #expect(original == decoded)
    }

    @Test("Description content is appropriate")
    func descriptionContent() {
        #expect(MiniProjectType.appLifecycle.description.contains("Foreground"))
        #expect(MiniProjectType.arc.description.contains("메모리"))
        #expect(MiniProjectType.gcd.description.contains("스레드"))
        #expect(MiniProjectType.runloop.description.contains("RunLoop"))
    }
}
