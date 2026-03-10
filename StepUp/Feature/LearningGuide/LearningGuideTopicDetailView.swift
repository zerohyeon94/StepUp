//
//  LearningGuideTopicDetailView.swift
//  StepUp
//

import SwiftUI

struct LearningGuideTopicDetailView: View {
    let topic: LearningTopic

    @State private var expandedSections: Set<UUID> = []

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                topicHeader

                ForEach(topic.sections) { section in
                    LearningSectionCardView(
                        section: section,
                        isExpanded: expandedSections.contains(section.id),
                        color: topic.color
                    ) {
                        toggleSection(section.id)
                    }
                }
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle(topic.title)
        .navigationBarTitleDisplayMode(.inline)
    }

    private var topicHeader: some View {
        HStack {
            Image(systemName: topic.iconName)
                .font(.largeTitle)
                .foregroundStyle(topic.color)

            VStack(alignment: .leading, spacing: 4) {
                Text("Step \(topic.order)")
                    .font(AppFonts.caption)
                    .foregroundStyle(.secondary)

                Text(topic.subtitle)
                    .font(AppFonts.body)
            }

            Spacer()
        }
        .padding()
        .background(topic.color.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    private func toggleSection(_ id: UUID) {
        withAnimation(.easeInOut(duration: 0.3)) {
            if expandedSections.contains(id) {
                expandedSections.remove(id)
            } else {
                expandedSections.insert(id)
            }
        }
    }
}
