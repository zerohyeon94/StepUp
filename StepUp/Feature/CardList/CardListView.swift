//
//  CardListView.swift
//  StepUp
//
//  Created by 조영현 on 3/4/26.
//

import SwiftUI
import SwiftData

struct CardListView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel: CardListViewModel?

    let coordinator: CardCoordinator

    var body: some View {
        Group {
            if let viewModel {
                CardListContentView(viewModel: viewModel, coordinator: coordinator)
            } else {
                ProgressView()
            }
        }
        .task {
            if viewModel == nil {
                viewModel = CardListViewModel(modelContext: modelContext)
            }
            await viewModel?.loadCards()
        }
        .onReceive(NotificationCenter.default.publisher(for: .cardsDidChange)) { _ in
            Task {
                await viewModel?.loadCards()
            }
        }
        .navigationTitle("면접 카드")
    }
}

// MARK: - Content View

private struct CardListContentView: View {
    @Bindable var viewModel: CardListViewModel
    let coordinator: CardCoordinator

    var body: some View {
        VStack(spacing: 0) {
            CategoryFilterView(selectedCategory: $viewModel.selectedCategory)

            if viewModel.isLoading {
                Spacer()
                ProgressView()
                Spacer()
            } else if viewModel.filteredCards.isEmpty {
                EmptyStateView()
            } else {
                cardList
            }
        }
        .searchable(text: $viewModel.searchText, prompt: "질문 검색")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewModel.showBookmarkedOnly.toggle()
                } label: {
                    Image(systemName: viewModel.showBookmarkedOnly ? "bookmark.fill" : "bookmark")
                }
            }
        }
    }

    private var cardList: some View {
        List {
            ForEach(viewModel.filteredCards) { card in
                CardRowView(card: card) {
                    viewModel.toggleBookmark(for: card)
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    coordinator.showDetail(card: card)
                }
            }
            .onDelete { indexSet in
                for index in indexSet {
                    viewModel.deleteCard(viewModel.filteredCards[index])
                }
            }
        }
        .listStyle(.plain)
    }
}
