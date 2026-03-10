//
//  LearningSectionCardView.swift
//  StepUp
//

import SwiftUI

struct LearningSectionCardView: View {
    let section: LearningSection
    let isExpanded: Bool
    let color: Color
    let onToggle: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            sectionHeader

            if isExpanded {
                Divider()
                expandedContent
            }
        }
        .cardStyle()
    }

    private var sectionHeader: some View {
        Button(action: onToggle) {
            HStack {
                Circle()
                    .fill(color.opacity(0.15))
                    .frame(width: 8, height: 8)

                Text(section.title)
                    .font(AppFonts.headline)
                    .foregroundStyle(.primary)
                    .multilineTextAlignment(.leading)

                Spacer()

                Image(systemName: "chevron.right")
                    .rotationEffect(.degrees(isExpanded ? 90 : 0))
                    .foregroundStyle(.secondary)
                    .animation(.easeInOut(duration: 0.2), value: isExpanded)
            }
            .padding()
        }
        .buttonStyle(.plain)
    }

    private var expandedContent: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(section.content)
                .font(AppFonts.body)

            if let code = section.codeExample {
                Text(code)
                    .font(.system(.caption, design: .monospaced))
                    .padding(12)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
        .padding()
    }
}
