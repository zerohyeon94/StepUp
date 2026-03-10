//
//  CardRowView.swift
//  StepUp
//
//  Created by 조영현 on 3/4/26.
//

import SwiftUI

struct CardRowView: View {
    let card: InterviewCard
    let onBookmarkTap: () -> Void

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            categoryIcon

            VStack(alignment: .leading, spacing: 4) {
                Text(card.question)
                    .font(AppFonts.headline)
                    .lineLimit(2)

                HStack {
                    Text(card.category.rawValue)
                        .font(AppFonts.caption)
                        .foregroundStyle(AppColors.categoryColor(card.category))

                    if card.miniProjectType != nil {
                        Label("데모", systemImage: "play.circle")
                            .font(AppFonts.caption)
                            .foregroundStyle(.secondary)
                    }
                }
            }

            Spacer()

            Button {
                onBookmarkTap()
            } label: {
                Image(systemName: card.isBookmarked ? "bookmark.fill" : "bookmark")
                    .foregroundStyle(card.isBookmarked ? AppColors.accent : .secondary)
            }
            .buttonStyle(.plain)
        }
        .padding(.vertical, 8)
    }

    private var categoryIcon: some View {
        Image(systemName: card.category.iconName)
            .font(.title2)
            .foregroundStyle(AppColors.categoryColor(card.category))
            .frame(width: 32, height: 32)
    }
}
