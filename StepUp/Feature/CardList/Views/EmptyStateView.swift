//
//  EmptyStateView.swift
//  StepUp
//
//  Created by 조영현 on 3/4/26.
//

import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        ContentUnavailableView(
            "카드가 없습니다",
            systemImage: "rectangle.stack.badge.plus",
            description: Text("새로운 면접 카드를 추가해보세요")
        )
    }
}
