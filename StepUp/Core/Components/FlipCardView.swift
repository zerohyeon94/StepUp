//
//  FlipCardView.swift
//  StepUp
//
//  Created by 조영현 on 3/4/26.
//

import SwiftUI

struct FlipCardView: View {
    let question: String
    let answer: String
    let isFlipped: Bool

    var body: some View {
        ZStack {
            CardFaceView(text: question, isQuestion: true)
                .opacity(isFlipped ? 0 : 1)
                .rotation3DEffect(
                    .degrees(isFlipped ? -180 : 0),
                    axis: (x: 0, y: 1, z: 0),
                    perspective: 0.5
                )

            CardFaceView(text: answer, isQuestion: false)
                .opacity(isFlipped ? 1 : 0)
                .rotation3DEffect(
                    .degrees(isFlipped ? 0 : 180),
                    axis: (x: 0, y: 1, z: 0),
                    perspective: 0.5
                )
        }
        .frame(height: 300)
    }
}

// MARK: - Card Face View

private struct CardFaceView: View {
    let text: String
    let isQuestion: Bool

    var body: some View {
        VStack(spacing: 16) {
            Label(
                isQuestion ? "질문" : "답변",
                systemImage: isQuestion ? "questionmark.circle" : "checkmark.circle"
            )
            .font(AppFonts.caption)
            .foregroundStyle(.secondary)

            ScrollView {
                Text(text)
                    .font(isQuestion ? AppFonts.cardQuestion : AppFonts.cardAnswer)
                    .multilineTextAlignment(.center)
            }
        }
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
    }
}

// MARK: - Preview

#Preview {
    FlipCardView(
        question: "iOS App 생명주기를 설명해보세요",
        answer: "iOS 앱은 Not Running, Inactive, Active, Background, Suspended 5가지 상태를 가집니다.",
        isFlipped: false
    )
    .padding()
}
