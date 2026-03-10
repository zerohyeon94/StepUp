//
//  LearningGuideTopicRowView.swift
//  StepUp
//

import SwiftUI

struct LearningGuideTopicRowView: View {
    let topic: LearningTopic

    var body: some View {
        HStack(spacing: 16) {
            orderBadge

            VStack(alignment: .leading, spacing: 4) {
                Text(topic.title)
                    .font(AppFonts.headline)

                Text(topic.subtitle)
                    .font(AppFonts.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }

            Spacer()

            Image(systemName: topic.iconName)
                .font(.title2)
                .foregroundStyle(topic.color)
        }
        .padding(.vertical, 8)
    }

    private var orderBadge: some View {
        ZStack {
            Circle()
                .fill(topic.color.opacity(0.15))
                .frame(width: 44, height: 44)

            Text("\(topic.order)")
                .font(AppFonts.headline)
                .foregroundStyle(topic.color)
        }
    }
}
