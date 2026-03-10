//
//  SwiftDataStack.swift
//  StepUp
//
//  Created by 조영현 on 3/4/26.
//

import SwiftData
import Foundation

enum SwiftDataStack {
    static func createModelContainer(inMemory: Bool = false) -> ModelContainer {
        let schema = Schema([InterviewCard.self])
        let configuration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: inMemory
        )

        do {
            return try ModelContainer(for: schema, configurations: [configuration])
        } catch {
            fatalError("Failed to create ModelContainer: \(error)")
        }
    }

    @MainActor
    static func seedInitialData(context: ModelContext) {
        let descriptor = FetchDescriptor<InterviewCard>()
        guard (try? context.fetchCount(descriptor)) == 0 else { return }

        let sampleCards = [
            InterviewCard(
                question: "iOS App 생명주기를 설명해보세요",
                answer: """
                iOS 앱은 5가지 상태를 가집니다:

                1. Not Running: 앱이 실행되지 않은 상태
                2. Inactive: 앱이 foreground에 있지만 이벤트를 받지 않는 상태
                3. Active: 앱이 foreground에서 실행 중이고 이벤트를 받는 상태
                4. Background: 앱이 background에서 코드를 실행 중인 상태
                5. Suspended: 앱이 background에 있지만 코드를 실행하지 않는 상태

                AppDelegate의 application(_:didFinishLaunchingWithOptions:)와
                SceneDelegate의 sceneDidBecomeActive(_:) 등의 메서드로 상태 변화를 감지합니다.
                """,
                category: .uikit,
                miniProjectType: .appLifecycle
            ),
            InterviewCard(
                question: "ARC(Automatic Reference Counting)란?",
                answer: """
                ARC는 Swift의 메모리 관리 기법으로, 클래스 인스턴스의 참조 카운트를 자동으로 관리합니다.

                주요 특징:
                - 컴파일 타임에 retain/release 코드를 자동 삽입
                - 참조 카운트가 0이 되면 메모리에서 해제
                - strong, weak, unowned 참조 타입 제공

                순환 참조(Retain Cycle) 방지:
                - weak: 참조 대상이 해제되면 nil이 됨
                - unowned: 참조 대상이 항상 존재한다고 가정 (해제 시 크래시)

                클로저에서의 캡처 리스트 [weak self] 사용이 중요합니다.
                """,
                category: .memory,
                miniProjectType: .arc
            ),
            InterviewCard(
                question: "GCD와 async/await의 차이점은?",
                answer: """
                GCD (Grand Central Dispatch):
                - 클로저 기반의 비동기 처리 API
                - DispatchQueue.main, .global() 사용
                - 콜백 중첩으로 인한 "콜백 지옥" 발생 가능

                async/await (Swift Concurrency):
                - Swift 5.5에서 도입된 구조적 동시성
                - 동기 코드처럼 읽히는 비동기 코드 작성
                - Task, TaskGroup으로 구조화된 동시성
                - Actor로 데이터 레이스 방지

                권장사항:
                - 새 코드는 async/await 사용
                - @MainActor로 UI 업데이트 보장
                - Task.detached보다 구조화된 Task 선호
                """,
                category: .concurrency,
                miniProjectType: .gcd
            ),
            InterviewCard(
                question: "Swift의 옵셔널(Optional)이란?",
                answer: """
                옵셔널은 값이 있을 수도, 없을 수도 있는 상황을 안전하게 처리하는 Swift의 타입입니다.

                선언: var name: String?

                옵셔널 해제 방법:
                1. if let (옵셔널 바인딩)
                   if let unwrapped = optional { ... }

                2. guard let (조기 반환)
                   guard let unwrapped = optional else { return }

                3. ?? (nil 병합 연산자)
                   let value = optional ?? defaultValue

                4. 옵셔널 체이닝
                   optional?.property?.method()

                ⚠️ Force Unwrap (!)은 런타임 크래시 위험으로 지양합니다.
                """,
                category: .swift
            ),
            InterviewCard(
                question: "MVVM 아키텍처 패턴을 설명해보세요",
                answer: """
                MVVM (Model-View-ViewModel):

                Model:
                - 데이터와 비즈니스 로직
                - 네트워크, 데이터베이스 접근

                View:
                - UI 표시 담당
                - 사용자 입력 전달
                - ViewModel 관찰

                ViewModel:
                - View와 Model 사이 중재자
                - 데이터 가공 및 상태 관리
                - View에 독립적 (테스트 용이)

                SwiftUI에서의 MVVM:
                - @StateObject: View가 소유하는 ViewModel
                - @ObservedObject: 외부에서 주입받는 ViewModel
                - @Published: 변경 시 View 업데이트 트리거
                """,
                category: .architecture
            ),
            InterviewCard(
                question: "URLSession을 이용한 네트워크 요청 방법은?",
                answer: """
                URLSession은 iOS의 기본 네트워킹 API입니다.

                async/await 방식:
                ```swift
                func fetchData() async throws -> Data {
                    let (data, response) = try await URLSession.shared.data(from: url)
                    guard let httpResponse = response as? HTTPURLResponse,
                          httpResponse.statusCode == 200 else {
                        throw NetworkError.invalidResponse
                    }
                    return data
                }
                ```

                JSON 디코딩:
                ```swift
                let decoder = JSONDecoder()
                let model = try decoder.decode(Model.self, from: data)
                ```

                주요 고려사항:
                - 에러 처리 (네트워크, 디코딩 에러)
                - 백그라운드 세션 (대용량 다운로드)
                - 캐싱 정책 설정
                """,
                category: .networking
            ),
            InterviewCard(
                question: "SwiftUI의 Property Wrapper를 설명해보세요",
                answer: """
                SwiftUI의 주요 Property Wrapper:

                @State:
                - View 내부 상태 관리
                - private으로 선언 권장
                - 값 타입에 사용

                @Binding:
                - 부모 View의 상태 참조
                - 양방향 데이터 바인딩

                @StateObject:
                - ObservableObject 소유
                - View가 생성/관리

                @ObservedObject:
                - 외부에서 주입받는 ObservableObject

                @EnvironmentObject:
                - 환경을 통해 전달되는 객체
                - 의존성 주입에 활용

                @Environment:
                - 시스템 환경 값 접근 (colorScheme 등)
                """,
                category: .swiftui
            )
        ]

        sampleCards.forEach { context.insert($0) }
    }
}
