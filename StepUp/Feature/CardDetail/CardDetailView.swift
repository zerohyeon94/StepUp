//
//  CardDetailView.swift
//  StepUp
//
//  Created by 조영현 on 3/4/26.
//

import SwiftUI
import SwiftData

struct CardDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel: CardDetailViewModel?

    let card: InterviewCard
    let coordinator: CardCoordinator

    var body: some View {
        Group {
            if let viewModel {
                CardDetailContentView(viewModel: viewModel, coordinator: coordinator)
            } else {
                ProgressView()
            }
        }
        .task {
            if viewModel == nil {
                viewModel = CardDetailViewModel(card: card, modelContext: modelContext)
            }
        }
        .navigationTitle("카드 상세")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Content View

private struct CardDetailContentView: View {
    @Bindable var viewModel: CardDetailViewModel
    let coordinator: CardCoordinator

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                instructionText

                FlipCardView(
                    question: viewModel.card.question,
                    answer: viewModel.card.answer,
                    isFlipped: viewModel.isFlipped
                )
                .onTapGesture {
                    viewModel.toggleFlip()
                }

                categoryBadge

                if viewModel.hasMiniProject {
                    miniProjectButton
                }
            }
            .padding()
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewModel.toggleBookmark()
                } label: {
                    Image(systemName: viewModel.card.isBookmarked ? "bookmark.fill" : "bookmark")
                        .foregroundStyle(viewModel.card.isBookmarked ? AppColors.accent : .primary)
                }
            }
        }
    }

    private var instructionText: some View {
        Text("카드를 탭하면 답변을 볼 수 있습니다")
            .font(AppFonts.caption)
            .foregroundStyle(.secondary)
    }

    private var categoryBadge: some View {
        HStack {
            Image(systemName: viewModel.card.category.iconName)
            Text(viewModel.card.category.rawValue)
        }
        .font(AppFonts.caption)
        .foregroundStyle(AppColors.categoryColor(viewModel.card.category))
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(AppColors.categoryColor(viewModel.card.category).opacity(0.1))
        .clipShape(Capsule())
    }

    private var miniProjectButton: some View {
        Button {
            if let type = viewModel.card.miniProjectType {
                coordinator.showMiniProject(type: type)
            }
        } label: {
            Label("미니 프로젝트 실행", systemImage: "play.circle.fill")
                .font(AppFonts.headline)
                .frame(maxWidth: .infinity)
                .padding()
                .background(AppColors.primary)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}
