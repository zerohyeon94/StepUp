//
//  MiniProjectType.swift
//  StepUp
//
//  Created by 조영현 on 3/4/26.
//

import Foundation

enum MiniProjectType: String, Codable, CaseIterable, Identifiable {
    case appLifecycle = "App 생명주기"
    case arc          = "ARC"
    case gcd          = "GCD / async-await"
    case runloop      = "RunLoop"

    var id: String { rawValue }

    var description: String {
        switch self {
        case .appLifecycle:
            return "실제 앱 상태 전환 시 알림 표시 (Foreground → Background → Suspended)"
        case .arc:
            return "객체 init/deinit을 시각적으로 표현하는 메모리 그래프"
        case .gcd:
            return "스레드 동작을 타임라인으로 비교 시각화"
        case .runloop:
            return "RunLoop 이벤트 흐름을 실시간으로 시각화"
        }
    }
}
