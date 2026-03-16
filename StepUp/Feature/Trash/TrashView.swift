//
//  TrashView.swift
//  StepUp
//
//  Created by Claude on 3/15/26.
//

import SwiftUI

struct TrashView: View {
    @State var viewModel: TrashViewModel
    @State private var showEmptyTrashAlert = false
    @State private var showRestoreAllAlert = false

    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView("불러오는 중...")
            } else if viewModel.deletedCards.isEmpty {
                emptyStateView
            } else {
                deletedCardList
            }
        }
        .navigationTitle("휴지통")
        .toolbar {
            if !viewModel.deletedCards.isEmpty {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    restoreAllButton
                    emptyTrashButton
                }
            }
        }
        .alert("전체 복원", isPresented: $showRestoreAllAlert) {
            Button("복원", role: .destructive) {
                viewModel.restoreAll()
            }
            Button("취소", role: .cancel) { }
        } message: {
            Text("삭제된 카드 \(viewModel.deletedCardCount)개를 모두 복원하시겠습니까?")
        }
        .alert("휴지통 비우기", isPresented: $showEmptyTrashAlert) {
            Button("비우기", role: .destructive) {
                viewModel.emptyTrash()
            }
            Button("취소", role: .cancel) { }
        } message: {
            Text("삭제된 카드 \(viewModel.deletedCardCount)개를 영구적으로 삭제하시겠습니까?\n이 작업은 되돌릴 수 없습니다.")
        }
        .task {
            await viewModel.loadDeletedCards()
        }
    }
}

// MARK: - Subviews

private extension TrashView {
    var emptyStateView: some View {
        ContentUnavailableView(
            "휴지통이 비어있습니다",
            systemImage: "trash",
            description: Text("삭제된 면접 카드가 여기에 표시됩니다.")
        )
    }

    var deletedCardList: some View {
        List {
            ForEach(viewModel.deletedCards) { card in
                TrashCardRow(card: card) {
                    viewModel.restoreCard(card)
                }
            }
            .onDelete { indexSet in
                for index in indexSet {
                    viewModel.permanentlyDelete(viewModel.deletedCards[index])
                }
            }
        }
    }

    var restoreAllButton: some View {
        Button {
            showRestoreAllAlert = true
        } label: {
            Image(systemName: "arrow.uturn.backward.circle")
        }
        .accessibilityLabel("전체 복원")
    }

    var emptyTrashButton: some View {
        Button {
            showEmptyTrashAlert = true
        } label: {
            Image(systemName: "trash.slash")
        }
        .accessibilityLabel("휴지통 비우기")
    }
}

// MARK: - TrashCardRow

private struct TrashCardRow: View {
    let card: InterviewCard
    let onRestore: () -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                categoryBadge
                questionText
                deletedDateText
            }

            Spacer()

            restoreButton
        }
        .padding(.vertical, 4)
    }
}

private extension TrashCardRow {
    var categoryBadge: some View {
        HStack(spacing: 4) {
            Image(systemName: card.category.iconName)
                .font(.caption2)
            Text(card.category.rawValue)
                .font(.caption2)
                .fontWeight(.medium)
        }
        .foregroundStyle(.secondary)
    }

    var questionText: some View {
        Text(card.question)
            .font(.subheadline)
            .lineLimit(2)
    }

    var deletedDateText: some View {
        Group {
            if let deletedAt = card.deletedAt {
                Text("삭제일: \(deletedAt.formatted(date: .abbreviated, time: .omitted))")
                    .font(.caption)
                    .foregroundStyle(.tertiary)
            }
        }
    }

    var restoreButton: some View {
        Button {
            onRestore()
        } label: {
            Image(systemName: "arrow.uturn.backward.circle.fill")
                .font(.title3)
                .foregroundStyle(.blue)
        }
        .buttonStyle(.plain)
        .accessibilityLabel("복원")
    }
}
