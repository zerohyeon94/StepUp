//
//  RunLoopDemoView.swift
//  StepUp
//
//  Created by 조영현 on 3/4/26.
//

import SwiftUI

struct RunLoopDemoView: View {
    var body: some View {
        ContentUnavailableView(
            "준비 중",
            systemImage: "clock.arrow.2.circlepath",
            description: Text("RunLoop 데모는 곧 추가될 예정입니다")
        )
    }
}

#Preview {
    RunLoopDemoView()
}
