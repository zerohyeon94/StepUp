//
//  CardListViewModelTests.swift
//  StepUpTests
//
//  Created by 조영현 on 3/4/26.
//

import Testing
import SwiftData
@testable import StepUp

@Suite("CardListViewModel Tests")
@MainActor
struct CardListViewModelTests {

    private func createTestContext() -> ModelContext {
        let container = SwiftDataStack.createModelContainer(inMemory: true)
        return container.mainContext
    }

    @Test("Initial state is correct")
    func initialState() {
        let context = createTestContext()
        let viewModel = CardListViewModel(modelContext: context)

        #expect(viewModel.cards.isEmpty)
        #expect(viewModel.isLoading == false)
        #expect(viewModel.error == nil)
        #expect(viewModel.selectedCategory == nil)
        #expect(viewModel.searchText.isEmpty)
        #expect(viewModel.showBookmarkedOnly == false)
    }

    @Test("Load cards fetches all cards")
    func loadCards() async {
        let context = createTestContext()

        // Insert test data
        let card1 = InterviewCard(question: "Q1", answer: "A1", category: .swift)
        let card2 = InterviewCard(question: "Q2", answer: "A2", category: .uikit)
        context.insert(card1)
        context.insert(card2)

        let viewModel = CardListViewModel(modelContext: context)
        await viewModel.loadCards()

        #expect(viewModel.cards.count == 2)
        #expect(viewModel.isLoading == false)
    }

    @Test("Filter by category works")
    func filterByCategory() async {
        let context = createTestContext()

        // Insert test data
        let swiftCard = InterviewCard(question: "Swift Q", answer: "A", category: .swift)
        let uikitCard = InterviewCard(question: "UIKit Q", answer: "A", category: .uikit)
        context.insert(swiftCard)
        context.insert(uikitCard)

        let viewModel = CardListViewModel(modelContext: context)
        await viewModel.loadCards()

        #expect(viewModel.filteredCards.count == 2)

        viewModel.selectedCategory = .swift
        #expect(viewModel.filteredCards.count == 1)
        #expect(viewModel.filteredCards.first?.category == .swift)

        viewModel.selectedCategory = .uikit
        #expect(viewModel.filteredCards.count == 1)
        #expect(viewModel.filteredCards.first?.category == .uikit)

        viewModel.selectedCategory = nil
        #expect(viewModel.filteredCards.count == 2)
    }

    @Test("Search filter works")
    func searchFilter() async {
        let context = createTestContext()

        let card1 = InterviewCard(question: "ARC Question", answer: "Memory", category: .memory)
        let card2 = InterviewCard(question: "GCD Question", answer: "Concurrency", category: .concurrency)
        context.insert(card1)
        context.insert(card2)

        let viewModel = CardListViewModel(modelContext: context)
        await viewModel.loadCards()

        viewModel.searchText = "ARC"
        #expect(viewModel.filteredCards.count == 1)
        #expect(viewModel.filteredCards.first?.question.contains("ARC") == true)

        viewModel.searchText = "Question"
        #expect(viewModel.filteredCards.count == 2)

        viewModel.searchText = "Memory"
        #expect(viewModel.filteredCards.count == 1)

        viewModel.searchText = ""
        #expect(viewModel.filteredCards.count == 2)
    }

    @Test("Bookmark filter works")
    func bookmarkFilter() async {
        let context = createTestContext()

        let card1 = InterviewCard(question: "Q1", answer: "A1", category: .swift)
        let card2 = InterviewCard(question: "Q2", answer: "A2", category: .swift)
        card1.isBookmarked = true
        context.insert(card1)
        context.insert(card2)

        let viewModel = CardListViewModel(modelContext: context)
        await viewModel.loadCards()

        #expect(viewModel.filteredCards.count == 2)

        viewModel.showBookmarkedOnly = true
        #expect(viewModel.filteredCards.count == 1)
        #expect(viewModel.filteredCards.first?.isBookmarked == true)

        viewModel.showBookmarkedOnly = false
        #expect(viewModel.filteredCards.count == 2)
    }

    @Test("Combined filters work")
    func combinedFilters() async {
        let context = createTestContext()

        let card1 = InterviewCard(question: "Swift ARC", answer: "A1", category: .swift)
        let card2 = InterviewCard(question: "Swift GCD", answer: "A2", category: .swift)
        let card3 = InterviewCard(question: "UIKit ARC", answer: "A3", category: .uikit)
        card1.isBookmarked = true
        card2.isBookmarked = true
        context.insert(card1)
        context.insert(card2)
        context.insert(card3)

        let viewModel = CardListViewModel(modelContext: context)
        await viewModel.loadCards()

        // Filter by category + search
        viewModel.selectedCategory = .swift
        viewModel.searchText = "ARC"
        #expect(viewModel.filteredCards.count == 1)
        #expect(viewModel.filteredCards.first?.question == "Swift ARC")

        // Filter by category + bookmark
        viewModel.searchText = ""
        viewModel.showBookmarkedOnly = true
        #expect(viewModel.filteredCards.count == 2)

        // All filters combined
        viewModel.searchText = "GCD"
        #expect(viewModel.filteredCards.count == 1)
        #expect(viewModel.filteredCards.first?.question == "Swift GCD")
    }

    @Test("Toggle bookmark updates card")
    func toggleBookmark() async {
        let context = createTestContext()

        let card = InterviewCard(question: "Q", answer: "A", category: .swift)
        context.insert(card)

        let viewModel = CardListViewModel(modelContext: context)
        await viewModel.loadCards()

        #expect(viewModel.cards.first?.isBookmarked == false)

        viewModel.toggleBookmark(for: card)
        #expect(card.isBookmarked == true)

        viewModel.toggleBookmark(for: card)
        #expect(card.isBookmarked == false)
    }

    @Test("Delete card removes from list")
    func deleteCard() async {
        let context = createTestContext()

        let card1 = InterviewCard(question: "Q1", answer: "A1", category: .swift)
        let card2 = InterviewCard(question: "Q2", answer: "A2", category: .uikit)
        context.insert(card1)
        context.insert(card2)

        let viewModel = CardListViewModel(modelContext: context)
        await viewModel.loadCards()

        #expect(viewModel.cards.count == 2)

        viewModel.deleteCard(card1)
        #expect(viewModel.cards.count == 1)
        #expect(viewModel.cards.first?.question == "Q2")
    }
}
