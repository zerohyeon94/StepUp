//
//  SwiftDataStack.swift
//  StepUp
//
//  Created by 조영현 on 3/4/26.
//

import SwiftData
import Foundation

// swiftlint:disable function_body_length type_body_length
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
            // MARK: - UIKit / iOS 기본

            InterviewCard(
                question: "iOS App 생명주기를 설명해보세요",
                answer: """
                iOS 앱은 5가지 상태를 가집니다:

                1. Not Running: 앱이 실행되지 않은 상태
                2. Inactive: 앱이 foreground에 있지만 이벤트를 받지 않는 상태
                3. Active: 앱이 foreground에서 실행 중이고 이벤트를 받는 상태
                4. Background: 앱이 background에서 코드를 실행 중인 상태
                5. Suspended: 앱이 background에 있지만 코드를 실행하지 않는 상태

                AppDelegate의 application(_:didFinishLaunchingWithOptions:)와 \
                SceneDelegate의 sceneDidBecomeActive(_:) 등의 메서드로 상태 변화를 감지합니다.
                """,
                category: .uikit,
                miniProjectType: .appLifecycle
            ),
            InterviewCard(
                question: "앱이 Background 상태에 진입한 후 Suspended 상태로 전환되기까지의 과정과 차이를 설명해주세요",
                answer: """
                앱이 홈 화면으로 나가면 먼저 Background 상태가 되어 약 5초간 작업을 마무리할 수 있습니다. \
                이 시간 안에 작업이 끝나면 시스템이 앱을 Suspended 상태로 전환합니다. \
                Suspended 상태에서는 메모리에는 남아있지만 코드가 실행되지 않으며, \
                시스템 메모리가 부족해지면 별도 알림 없이 종료될 수 있습니다. \
                추가 시간이 필요하면 beginBackgroundTask(expirationHandler:)로 요청할 수 있습니다.
                """,
                category: .uikit
            ),
            InterviewCard(
                question: "UIViewController의 생명주기(Lifecycle) 메서드를 순서대로 설명해주세요",
                answer: """
                1. loadView(): 뷰를 코드로 직접 구성할 때 호출
                2. viewDidLoad(): 뷰가 메모리에 로드된 후 1회 호출 (초기 설정)
                3. viewWillAppear(_:): 화면에 나타나기 직전 (매번 호출)
                4. viewDidAppear(_:): 화면에 완전히 나타난 후 (애니메이션, 타이머 시작)
                5. viewWillDisappear(_:): 화면에서 사라지기 직전
                6. viewDidDisappear(_:): 화면에서 완전히 사라진 후 (리소스 정리)
                """,
                category: .uikit
            ),
            InterviewCard(
                question: "iOS의 Responder Chain(응답자 사슬)에 대해 설명해주세요",
                answer: """
                사용자의 터치나 이벤트가 발생했을 때, 해당 이벤트를 처리할 수 있는 객체(Responder)를 \
                찾을 때까지 뷰 계층을 따라 이벤트를 전달하는 메커니즘입니다. \
                이벤트가 발생한 첫 번째 뷰(First Responder)가 이벤트를 처리하지 못하면 \
                상위 뷰로, 그 다음엔 View Controller, UIWindow, UIApplication, \
                최종적으로 App Delegate까지 전달되며, 아무도 처리하지 않으면 이벤트는 소멸됩니다.
                """,
                category: .uikit
            ),
            InterviewCard(
                question: "UIKit에서 frame과 bounds의 차이를 설명해주세요",
                answer: """
                frame은 상위 뷰(Superview)의 좌표계를 기준으로 한 뷰의 위치(origin)와 크기(size)입니다. \
                bounds는 자기 자신의 좌표계를 기준으로 한 원점과 크기입니다. \
                frame은 뷰의 위치와 크기를 설정할 때, bounds는 뷰 내부의 콘텐츠를 배치하거나 \
                스크롤 위치를 조정할 때 주로 사용합니다. \
                뷰가 회전하면 frame의 크기는 변하지만 bounds는 그대로 유지됩니다.
                """,
                category: .uikit
            ),
            InterviewCard(
                question: "테이블 뷰에서 셀(Cell)을 재사용하는 원리와 prepareForReuse()의 역할을 설명해주세요",
                answer: """
                리스트에 수백 개의 데이터가 있더라도 화면에 보이는 만큼의 셀만 메모리에 할당하고, \
                스크롤 시 화면 밖으로 벗어난 셀은 '재사용 큐(Reuse Queue)'에 넣습니다. \
                새로 화면에 나타날 데이터는 큐에 있는 셀을 꺼내어 데이터만 덮어씌워 보여줌으로써 메모리를 최적화합니다. \
                prepareForReuse()는 셀이 재사용되기 직전에 호출되는 메서드로, \
                이전 셀에 남아있던 이미지나 텍스트, 상태 값 등을 초기화하여 데이터가 겹쳐 보이는 UI 버그를 방지합니다.
                """,
                category: .uikit
            ),
            InterviewCard(
                question: "앱의 실행 시간(Launch Time)을 줄이기 위해 어떤 최적화를 할 수 있나요?",
                answer: """
                Pre-main 단계에서는 불필요한 Dynamic Framework 수를 줄이고, \
                +load 메서드나 static initializer 사용을 최소화합니다. \
                Post-main 단계에서는 AppDelegate/SceneDelegate에서 무거운 초기화를 지연시키고, \
                첫 화면에 필요한 데이터만 우선 로드합니다. \
                Instruments의 App Launch 템플릿으로 병목 구간을 프로파일링하여 측정할 수 있습니다.
                """,
                category: .uikit
            ),
            InterviewCard(
                question: "iOS에서 백그라운드 작업을 처리하는 방법에는 어떤 것이 있나요?",
                answer: """
                1. beginBackgroundTask: 앱이 백그라운드에 진입한 직후 짧은 시간(약 30초) 동안 작업 완료
                2. BGTaskScheduler: iOS 13+에서 도입된 API로, BGAppRefreshTask(주기적 데이터 갱신)와 \
                BGProcessingTask(대용량 작업)를 스케줄링
                3. URLSession Background Session: 앱이 Suspended 상태여도 대용량 파일 다운로드/업로드를 \
                시스템이 대신 처리
                4. Silent Push Notification: 서버에서 보내는 무음 알림으로 앱을 깨워 데이터 갱신
                """,
                category: .uikit
            ),
            InterviewCard(
                question: "앱 실행 중 메모리 부족 경고(Memory Warning)를 받았을 때 어떻게 대응해야 하나요?",
                answer: """
                시스템 메모리가 부족해지면 iOS는 didReceiveMemoryWarning() 메서드나 \
                UIApplication.didReceiveMemoryWarningNotification 알림을 보냅니다. \
                이때 앱은 현재 화면에 보이지 않는 뷰, 다시 로드할 수 있는 이미지 캐시나 \
                대용량 데이터 파일 등 불필요한 메모리를 즉각적으로 해제하여 \
                앱이 강제 종료(OOM, Out of Memory)되는 것을 막아야 합니다.
                """,
                category: .uikit
            ),

            // MARK: - Swift 언어

            InterviewCard(
                question: "Swift의 옵셔널(Optional)이란?",
                answer: """
                옵셔널은 값이 있을 수도, 없을 수도 있는 상황을 안전하게 처리하는 Swift의 타입입니다. \
                내부적으로 enum Optional<Wrapped> { case some(Wrapped), case none }으로 구현되어 있습니다.

                옵셔널 해제 방법:
                1. if let / guard let (옵셔널 바인딩)
                2. ?? (nil 병합 연산자)
                3. 옵셔널 체이닝: optional?.property?.method()

                Force Unwrap (!)은 런타임 크래시 위험으로 지양합니다.
                """,
                category: .swift
            ),
            InterviewCard(
                question: "클래스(Class)와 구조체(Struct)의 차이점은 무엇인가요?",
                answer: """
                가장 큰 차이는 클래스는 참조 타입(Reference Type), 구조체는 값 타입(Value Type)입니다. \
                클래스는 힙(Heap) 메모리에 저장되고 ARC로 관리되며, 상속이 가능합니다. \
                구조체는 스택(Stack) 메모리에 저장되어 성능이 빠르고, 복사 시 독립적인 복사본이 생깁니다. \
                Swift에서는 불변성과 스레드 안전성을 위해 구조체 사용을 권장하며, \
                상속이 필요하거나 참조 공유가 필요한 경우에만 클래스를 사용합니다.
                """,
                category: .swift
            ),
            InterviewCard(
                question: "구조체(Struct)에서 mutating 키워드를 붙이는 이유는 무엇인가요?",
                answer: """
                구조체는 값 타입이기 때문에, 인스턴스가 상수로 선언되면 내부 프로퍼티도 모두 상수가 되어 수정할 수 없습니다. \
                mutating 키워드는 해당 메서드가 구조체의 상태(프로퍼티)를 변경할 수 있다는 것을 \
                컴파일러에게 명시적으로 알려주는 역할을 합니다. \
                내부적으로는 mutating 메서드가 호출될 때, 기존 구조체를 변경하는 것이 아니라 \
                변경된 값을 가진 새로운 구조체를 생성하여 현재 인스턴스에 다시 할당(Reassignment)하는 방식으로 동작합니다.
                """,
                category: .swift
            ),
            InterviewCard(
                question: "Any와 AnyObject의 차이는 무엇인가요?",
                answer: """
                Any는 함수, 구조체, 열거형, 클래스 등 Swift의 모든 타입의 인스턴스를 나타낼 수 있는 범용 타입입니다. \
                반면 AnyObject는 모든 '클래스(Class)' 타입의 인스턴스만 나타낼 수 있는 프로토콜입니다. \
                따라서 값 타입(Struct, Enum)은 AnyObject로 캐스팅할 수 없습니다.
                """,
                category: .swift
            ),
            InterviewCard(
                question: "Swift에서 defer 구문은 언제, 왜 사용하나요?",
                answer: """
                defer는 현재 스코프가 종료되기 직전에 반드시 실행되어야 하는 코드를 예약하는 구문입니다. \
                함수가 어떤 경로로 종료되든(정상 return, throw, guard 탈출 등) 반드시 실행되므로, \
                파일 닫기, 락 해제, 리소스 정리 등 cleanup 코드에 주로 사용합니다. \
                여러 개의 defer가 있으면 선언 역순(LIFO)으로 실행됩니다.
                """,
                category: .swift
            ),
            InterviewCard(
                question: "static 메서드와 class 메서드의 차이는 무엇인가요?",
                answer: """
                둘 다 타입 자체에서 호출하는 타입 메서드입니다. \
                static은 구조체, 열거형, 클래스 모두에서 사용 가능하며 오버라이딩이 불가능합니다. \
                class 메서드는 클래스에서만 사용 가능하며, 하위 클래스에서 override 할 수 있습니다. \
                즉, 재정의가 필요하면 class를, 고정된 구현이면 static을 사용합니다.
                """,
                category: .swift
            ),
            InterviewCard(
                question: "접근 제어자 중 fileprivate와 private의 차이는 무엇인가요?",
                answer: """
                fileprivate은 해당 요소가 작성된 '소스 파일(.swift) 전체' 내부에서 접근할 수 있습니다. \
                반면 private은 정의된 '해당 블록(스코프)' 내부와, \
                동일한 파일 내에 있는 해당 타입의 extension에서만 접근할 수 있어 캡슐화의 강도가 가장 높습니다.
                """,
                category: .swift
            ),
            InterviewCard(
                question: "Swift에서 제네릭(Generics)을 사용하는 이유는 무엇인가요?",
                answer: """
                제네릭은 타입에 의존하지 않고 범용적이고 재사용 가능한 코드를 작성하기 위해 사용합니다. \
                함수나 타입을 정의할 때 타입 매개변수(<T>)를 사용하여, 호출되는 시점에 실제 타입이 결정되도록 합니다. \
                코드의 중복을 막고, 타입 안정성(Type Safety)을 유지하면서 유연한 프로그래밍이 가능해집니다. \
                Array나 Dictionary 같은 컬렉션 타입이 제네릭으로 구현된 대표적인 예입니다.
                """,
                category: .swift
            ),
            InterviewCard(
                question: "do-catch 구문과 Result 타입의 차이점은 무엇인가요?",
                answer: """
                do-catch는 에러를 던질 수 있는(throws) 함수를 동기적인 흐름에서 직관적으로 처리할 때 유용합니다. \
                하지만 비동기 작업의 완료 클로저 내부에서는 에러를 던지기 어렵다는 단점이 있습니다. \
                Result 타입은 성공(success)과 실패(failure)를 명확하게 캡슐화한 열거형으로, \
                비동기 작업의 결과를 반환하거나 에러를 값처럼 전달해야 할 때 유용하게 쓰입니다.
                """,
                category: .swift
            ),
            InterviewCard(
                question: "Copy-on-Write(COW) 기법이란 무엇인가요?",
                answer: """
                Swift의 Array, Dictionary 등 컬렉션은 값 타입이지만, \
                매번 복사하면 성능이 떨어지므로 실제로 값이 변경되기 전까지는 원본과 같은 메모리를 공유합니다. \
                수정이 일어나는 시점에만 실제 복사가 수행되어, 불필요한 복사 비용을 줄이고 성능을 최적화합니다.
                """,
                category: .swift
            ),
            InterviewCard(
                question: "map, filter, reduce 고차함수에 대해 설명해주세요",
                answer: """
                map: 컬렉션의 각 요소를 변환하여 새로운 배열을 생성합니다. \
                filter: 조건을 만족하는 요소만 걸러내어 새로운 배열을 만듭니다. \
                reduce: 컬렉션의 모든 요소를 하나의 값으로 결합합니다. \
                이 고차함수들은 for-in 반복문보다 간결하고, 함수형 프로그래밍 스타일로 \
                데이터를 가공할 때 가독성과 안정성이 높습니다.
                """,
                category: .swift
            ),
            InterviewCard(
                question: "Codable 프로토콜은 내부적으로 어떻게 구성되어 있나요?",
                answer: """
                Codable은 외부 표현(JSON 등)을 Swift 모델로 변환하는 Decodable 프로토콜과, \
                Swift 모델을 외부 표현으로 변환하는 Encodable 프로토콜을 합친 타입 에일리어스입니다. \
                속성 이름과 JSON의 키 값이 다를 경우 CodingKeys 열거형을 정의하여 매핑할 수 있습니다.
                """,
                category: .swift
            ),
            InterviewCard(
                question: "Collection Types(Array, Dictionary, Set)의 특징과 차이점을 설명해주세요",
                answer: """
                Array: 순서가 있는 컬렉션으로 중복 허용, 인덱스로 접근 가능. \
                Dictionary: 키-값 쌍으로 저장, 키는 고유해야 하며 Hashable 프로토콜 필요. \
                Set: 순서가 없고 중복을 허용하지 않는 컬렉션, 집합 연산(합집합, 교집합 등) 지원. \
                모두 값 타입이며 Copy-on-Write로 성능을 최적화합니다.
                """,
                category: .swift
            ),
            InterviewCard(
                question: "프로토콜 지향 프로그래밍(POP)의 장점은 무엇인가요?",
                answer: """
                객체지향(OOP)에서는 다형성을 위해 주로 클래스의 '상속'을 사용하지만, \
                다중 상속이 불가능하고 불필요한 기능까지 물려받아야 하는 단점이 있습니다. \
                프로토콜 지향 프로그래밍(POP)은 프로토콜을 통해 수평적인 기능 확장이 가능하며, \
                값 타입(Struct, Enum)에도 다형성을 부여할 수 있습니다. \
                프로토콜 초기 구현(Protocol Extension)을 통해 코드 중복을 줄이고 \
                모듈화와 테스트 용이성을 크게 높일 수 있습니다.
                """,
                category: .swift
            ),
            InterviewCard(
                question: "Hashable과 Equatable 프로토콜의 역할과 관계를 설명해주세요",
                answer: """
                Equatable은 두 인스턴스가 같은지 비교(==)할 수 있게 해주는 프로토콜입니다. \
                Hashable은 Equatable을 상속하며, 인스턴스를 해시 값으로 변환하여 \
                Dictionary의 키나 Set의 원소로 사용할 수 있게 합니다. \
                Swift의 기본 타입(String, Int 등)은 이미 Hashable을 준수하며, \
                커스텀 타입도 저장 프로퍼티가 모두 Hashable이면 자동으로 합성됩니다.
                """,
                category: .swift
            ),

            // MARK: - 메모리

            InterviewCard(
                question: "ARC(Automatic Reference Counting)란?",
                answer: """
                ARC는 Swift의 메모리 관리 기법으로, 클래스 인스턴스의 참조 카운트를 자동으로 관리합니다. \
                컴파일 타임에 retain/release 코드를 자동 삽입하며, 참조 카운트가 0이 되면 메모리에서 해제합니다. \
                strong, weak, unowned 참조 타입을 제공하며, \
                순환 참조(Retain Cycle)를 방지하기 위해 weak이나 unowned를 적절히 사용해야 합니다.
                """,
                category: .memory,
                miniProjectType: .arc
            ),
            InterviewCard(
                question: "weak 참조와 unowned 참조의 차이를 설명해주세요",
                answer: """
                둘 다 강한 참조 순환을 방지하기 위해 참조 카운트를 올리지 않는 참조 방식입니다. \
                weak은 참조 대상이 해제되면 자동으로 nil이 되므로 항상 옵셔널 타입이며, \
                참조 대상의 생명 주기가 더 짧을 수 있을 때 사용합니다. \
                unowned은 참조 대상이 항상 존재한다고 가정하여 비옵셔널이지만, \
                해제된 후 접근하면 크래시가 발생합니다. 참조 대상의 생명 주기가 같거나 더 긴 것이 확실할 때 사용합니다.
                """,
                category: .memory
            ),
            InterviewCard(
                question: "클로저에서 캡처 리스트(Capture List)를 사용하는 이유를 설명해주세요",
                answer: """
                클로저는 주변 환경의 변수나 상수를 캡처할 때 기본적으로 강한 참조(Strong Reference)를 사용합니다. \
                클래스의 인스턴스가 클로저를 프로퍼티로 가지고 있고, 그 클로저 내부에서 self를 참조하면 \
                서로가 서로를 강하게 참조하는 순환 참조가 발생해 메모리 누수가 생깁니다. \
                이를 방지하기 위해 캡처 리스트에 [weak self] 또는 [unowned self]를 명시하여 \
                참조 카운트가 올라가지 않도록 처리해야 합니다.
                """,
                category: .memory
            ),
            InterviewCard(
                question: "메모리 누수(Memory Leak)를 디버깅하기 위해 어떤 도구를 사용하나요?",
                answer: """
                가장 기본적인 방법은 deinit 블록에 print 문을 작성하여 정상적으로 호출되는지 확인하는 것입니다. \
                도구로는 Xcode의 Debug Memory Graph를 켜서 강하게 참조하고 있는 객체가 있는지 \
                시각적으로 확인합니다. 더 상세한 분석이 필요할 때는 Xcode의 Instruments 도구 중 \
                Leaks나 Allocations를 사용하여 앱 실행 중 발생하는 메모리 누수 지점과 \
                객체의 생명주기를 프로파일링합니다.
                """,
                category: .memory
            ),

            // MARK: - 동시성

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

                새 코드는 async/await를 사용하고, @MainActor로 UI 업데이트를 보장하는 것이 권장됩니다.
                """,
                category: .concurrency,
                miniProjectType: .gcd
            ),
            InterviewCard(
                question: "Main Queue와 Global Queue의 차이점과 UI 업데이트 시 주의할 점은?",
                answer: """
                Main Queue는 단일 스레드에서 직렬로 동작하며 앱의 UI 업데이트를 전담합니다. \
                Global Queue는 동시성 큐로 백그라운드에서 무거운 연산이나 네트워크 통신을 처리합니다. \
                네트워크 통신은 Global Queue에서 비동기적으로 처리되지만, \
                통신 완료 후 UI 업데이트 작업은 반드시 DispatchQueue.main.async를 통해 \
                Main Queue로 보내서 처리해야 화면 멈춤이나 크래시를 방지할 수 있습니다.
                """,
                category: .concurrency
            ),
            InterviewCard(
                question: "GCD의 DispatchQueue와 OperationQueue의 차이를 설명해주세요",
                answer: """
                DispatchQueue는 GCD 기반의 경량 API로, 간단한 비동기 작업에 적합합니다. \
                OperationQueue는 Operation 객체를 기반으로 하며, 작업 간 의존성 설정, \
                취소(cancel), 우선순위 조정, 최대 동시 실행 개수 제한 등 세밀한 제어가 가능합니다. \
                간단한 비동기 작업에는 GCD를, 복잡한 작업 흐름이 필요할 때는 OperationQueue를 선택합니다.
                """,
                category: .concurrency
            ),
            InterviewCard(
                question: "Swift의 Actor란 무엇이며, 어떤 문제를 해결하나요?",
                answer: """
                Actor는 Swift 5.5에서 도입된 참조 타입으로, 내부 상태에 대한 동시 접근을 컴파일러 수준에서 보호합니다. \
                Actor 내부 프로퍼티나 메서드에 외부에서 접근하려면 반드시 await를 붙여야 하며, \
                한 번에 하나의 Task만 Actor 내부 코드를 실행할 수 있어 Data Race를 원천적으로 방지합니다. \
                기존의 수동 락(NSLock, DispatchQueue sync) 대신 안전하고 선언적인 동시성 모델을 제공합니다.
                """,
                category: .concurrency
            ),
            InterviewCard(
                question: "async/await와 기존 @escaping 클로저 기반 비동기 코드의 차이는?",
                answer: """
                @escaping 클로저 방식은 비동기 완료 시 콜백을 호출하므로 중첩되면 코드가 복잡해지고, \
                에러 처리가 일관되지 않으며, 실행 흐름을 추적하기 어렵습니다. \
                async/await는 비동기 코드를 동기 코드처럼 순차적으로 작성할 수 있어 가독성이 높고, \
                try/catch로 에러를 일관되게 처리할 수 있으며, \
                컴파일러가 동시성 관련 오류를 사전에 잡아줍니다.
                """,
                category: .concurrency
            ),

            // MARK: - 아키텍처

            InterviewCard(
                question: "MVVM 아키텍처 패턴을 설명해보세요",
                answer: """
                MVVM (Model-View-ViewModel):

                Model: 데이터와 비즈니스 로직, 네트워크/데이터베이스 접근
                View: UI 표시 담당, 사용자 입력 전달, ViewModel 관찰
                ViewModel: View와 Model 사이 중재자, 데이터 가공 및 상태 관리, View에 독립적(테스트 용이)

                SwiftUI에서는 @StateObject로 ViewModel을 소유하고, \
                @Published 프로퍼티 변경 시 View가 자동으로 업데이트됩니다.
                """,
                category: .architecture
            ),
            InterviewCard(
                question: "MVC 패턴과 MVVM 패턴의 차이점은 무엇인가요?",
                answer: """
                MVC에서 Controller는 View와 Model 사이의 모든 로직을 담당하여 \
                코드가 비대해지는 Massive View Controller 문제가 발생합니다. \
                MVVM에서 ViewModel은 View에 대한 직접 참조 없이 데이터 바인딩으로 소통하므로 \
                결합도가 낮고 단위 테스트가 용이합니다. \
                SwiftUI의 데이터 바인딩 메커니즘(@State, @Published)이 MVVM과 자연스럽게 어울립니다.
                """,
                category: .architecture
            ),
            InterviewCard(
                question: "의존성 주입(Dependency Injection)의 구현 방법과 이점은 무엇인가요?",
                answer: """
                객체를 내부에서 직접 생성하지 않고 외부에서 주입받는 방식으로, \
                이니셜라이저 주입(Initializer Injection), 프로퍼티 주입(Property Injection), \
                메서드 주입(Method Injection)을 사용합니다. \
                가장 큰 이점은 객체 간의 결합도를 낮춰 유연한 코드를 만들 수 있다는 점이며, \
                특히 테스트 시 가짜 객체(Mock)를 쉽게 주입할 수 있어 단위 테스트 작성이 수월해집니다.
                """,
                category: .architecture
            ),
            InterviewCard(
                question: "의존성 역전 원칙(DIP)이란 무엇이며, Swift에서 어떻게 적용하나요?",
                answer: """
                DIP(Dependency Inversion Principle)는 상위 모듈이 하위 모듈에 직접 의존하지 않고, \
                둘 다 추상화(프로토콜)에 의존해야 한다는 SOLID 원칙 중 하나입니다. \
                Swift에서는 프로토콜을 정의하고 구체 타입이 이를 채택하게 한 뒤, \
                사용하는 쪽에서는 프로토콜 타입으로 참조하여 구현체를 쉽게 교체하거나 \
                테스트용 Mock을 주입할 수 있게 합니다.
                """,
                category: .architecture
            ),
            InterviewCard(
                question: "Delegate 패턴과 NotificationCenter의 차이점을 설명해주세요",
                answer: """
                Delegate 패턴은 주로 1:1 통신에 사용되며 프로토콜을 통해 요구사항이 명확히 정의되어 \
                흐름 추적이 쉽지만, 객체 간 결합도가 생길 수 있습니다. \
                반면 NotificationCenter는 1:N 통신이 가능하여 여러 객체에 동시에 이벤트를 알릴 때 유리하며 \
                결합도가 낮습니다. 하지만 이벤트의 출처나 흐름을 추적하기 어려워 디버깅이 까다로울 수 있습니다.
                """,
                category: .architecture
            ),
            InterviewCard(
                question: "싱글톤(Singleton) 패턴의 문제점(안티 패턴)은 무엇인가요?",
                answer: """
                싱글톤은 전역에서 접근 가능하므로 어디서든 상태를 변경할 수 있어 데이터 흐름 추적이 어렵습니다. \
                앱이 종료될 때까지 메모리에 남아 메모리 낭비의 원인이 될 수 있습니다. \
                멀티 스레드 환경에서 동시 접근 시 데이터 경합(Data Race) 문제가 발생하기 쉬우며, \
                의존성이 강하게 결합되어 독립적인 단위 테스트를 수행하기 어렵습니다.
                """,
                category: .architecture
            ),
            InterviewCard(
                question: "Git Merge와 Rebase의 차이점과 사용 시나리오는?",
                answer: """
                Merge는 두 브랜치의 변경 사항을 합치면서 병합 커밋(Merge Commit)을 생성합니다. \
                브랜치 히스토리가 보존되지만 커밋 트리가 복잡해질 수 있습니다. \
                Rebase는 현재 브랜치의 커밋들을 대상 브랜치의 최신 커밋 위로 옮겨 붙여 \
                히스토리를 일직선으로 깔끔하게 만듭니다. \
                개인 작업 브랜치를 최신 상태로 유지할 때는 Rebase가 좋고, \
                공용 브랜치(main)에 합칠 때는 히스토리 추적을 위해 Merge가 안전합니다.
                """,
                category: .architecture
            ),

            // MARK: - SwiftUI

            InterviewCard(
                question: "SwiftUI의 Property Wrapper를 설명해보세요",
                answer: """
                @State: View 내부 상태 관리, private 선언 권장, 값 타입에 사용
                @Binding: 부모 View의 상태 참조, 양방향 데이터 바인딩
                @StateObject: ObservableObject 소유, View가 생성/관리
                @ObservedObject: 외부에서 주입받는 ObservableObject
                @EnvironmentObject: 환경을 통해 전달되는 객체, 의존성 주입에 활용
                @Environment: 시스템 환경 값 접근 (colorScheme 등)
                """,
                category: .swiftui
            ),
            InterviewCard(
                question: "@StateObject와 @ObservedObject의 차이점은 무엇인가요?",
                answer: """
                둘 다 ObservableObject를 준수하는 객체의 상태 변화를 감지하여 뷰를 렌더링합니다. \
                가장 큰 차이는 '생명 주기 관리'에 있습니다. \
                @StateObject는 해당 뷰가 처음 생성될 때 한 번만 인스턴스를 초기화하고 \
                뷰가 다시 그려져도 객체를 유지(소유)합니다. \
                반면 @ObservedObject는 뷰가 다시 그려질 때 객체가 초기화되어 \
                데이터가 유실될 위험이 있으므로, 주로 상위 뷰에서 생성된 객체를 주입받아 사용할 때 씁니다.
                """,
                category: .swiftui
            ),
            InterviewCard(
                question: "GeometryReader란 무엇이며 언제 사용하나요?",
                answer: """
                GeometryReader는 부모 뷰가 제안하는 크기(size)와 좌표 공간(coordinate space) 정보를 \
                자식 뷰에 전달하는 컨테이너 뷰입니다. \
                화면 크기에 비례한 레이아웃, 스크롤 위치 감지, 커스텀 정렬 등에 사용됩니다. \
                다만, GeometryReader는 제안받은 공간 전체를 차지하므로 \
                남용하면 레이아웃이 깨질 수 있어 꼭 필요한 곳에서만 사용해야 합니다.
                """,
                category: .swiftui
            ),
            InterviewCard(
                question: "withAnimation과 .animation() 모디파이어의 차이는 무엇인가요?",
                answer: """
                withAnimation 블록은 상태 값(State)을 변경하는 이벤트 자체를 감싸서, \
                그 상태 변화로 인해 영향을 받는 모든 뷰에 명시적으로 애니메이션을 적용합니다 (명령형 접근). \
                반면 .animation() 모디파이어는 특정 뷰에 붙여서 특정 값이 변경될 때마다 \
                자동으로 애니메이션이 반응하도록 설정합니다 (선언형 접근). \
                의도치 않은 애니메이션을 막기 위해 .animation(_:value:) 형태로 명시하는 것을 권장합니다.
                """,
                category: .swiftui
            ),
            InterviewCard(
                question: ".onAppear와 .task 모디파이어의 차이점은 무엇인가요?",
                answer: """
                .onAppear는 뷰가 화면에 나타날 때마다 호출되며, 동기 코드를 실행하는 데 적합합니다. \
                .task는 뷰가 나타날 때 비동기 작업을 자동으로 시작하고, \
                뷰가 사라지면 해당 Task를 자동으로 취소(cancel)해줍니다. \
                비동기 데이터 로딩에는 .task가 더 안전하며, 뷰의 생명주기와 비동기 작업의 생명주기를 자동으로 맞춰줍니다.
                """,
                category: .swiftui
            ),
            InterviewCard(
                question: "SwiftUI에서 UIKit 뷰를 사용하려면 어떻게 하나요?",
                answer: """
                UIView를 띄우려면 UIViewRepresentable을, UIViewController를 띄우려면 \
                UIViewControllerRepresentable 프로토콜을 사용합니다. \
                makeUIView(context:)에서 UIKit 뷰를 초기화하고, \
                updateUIView(_:context:)에서 SwiftUI의 상태 변화를 UIKit 뷰에 반영합니다. \
                반대로 UIKit 뷰에서 발생한 이벤트를 SwiftUI로 전달하려면 \
                Coordinator 객체를 만들어 Delegate 패턴으로 데이터를 동기화합니다.
                """,
                category: .swiftui
            ),
            InterviewCard(
                question: "@State와 @Binding의 차이점과 사용법을 설명해주세요",
                answer: """
                @State는 뷰가 직접 소유하는 상태로, 값이 바뀌면 해당 뷰가 자동으로 다시 그려집니다. \
                private으로 선언하며 해당 뷰 내부에서만 읽기/쓰기가 가능합니다. \
                @Binding은 상위 뷰의 @State를 하위 뷰에서 읽고 쓸 수 있도록 하는 양방향 참조입니다. \
                상위 뷰에서 $state 형태로 바인딩을 전달하며, \
                하위 뷰에서 값을 변경하면 상위 뷰의 원본 상태도 함께 업데이트됩니다.
                """,
                category: .swiftui
            ),

            // MARK: - 네트워킹

            InterviewCard(
                question: "URLSession을 이용한 네트워크 요청 방법은?",
                answer: """
                URLSession은 iOS의 기본 네트워킹 API입니다. \
                async/await 방식으로 let (data, response) = try await URLSession.shared.data(from: url) \
                형태로 간결하게 요청할 수 있습니다. \
                응답의 HTTP 상태 코드를 확인하고, JSONDecoder로 모델을 디코딩합니다. \
                주요 고려사항으로 에러 처리, 백그라운드 세션, 캐싱 정책 설정이 있습니다.
                """,
                category: .networking
            ),
            InterviewCard(
                question: "URLSession의 세 가지 주요 Task의 차이점을 설명해주세요",
                answer: """
                URLSessionDataTask는 서버로부터 데이터를 메모리(Data 객체)로 직접 받아오며 \
                짧은 JSON 통신에 적합합니다. \
                URLSessionDownloadTask는 데이터를 파일 형태로 디스크에 직접 다운로드하여 \
                백그라운드 전송이나 대용량 파일 처리에 적합합니다. \
                URLSessionUploadTask는 로컬 파일이나 Data 객체를 서버로 전송할 때 사용됩니다.
                """,
                category: .networking
            ),
            InterviewCard(
                question: "네트워크 통신 중 토큰 만료 시 자동으로 갱신하는 방법은?",
                answer: """
                URLProtocol 서브클래스를 만들어 모든 요청을 가로채고 401 응답 시 \
                refresh token으로 새 access token을 발급받아 원래 요청을 재시도하는 방법이 있습니다. \
                또는 API 클라이언트 레이어에서 인터셉터 패턴을 구현하여, \
                요청 전에 토큰 만료 여부를 확인하고 선제적으로 갱신할 수도 있습니다. \
                동시에 여러 요청이 401을 받는 경우 갱신 요청이 중복되지 않도록 \
                하나의 Task로 묶어 처리하는 것이 중요합니다.
                """,
                category: .networking
            ),
            InterviewCard(
                question: "민감한 데이터를 저장할 때 UserDefaults 대신 KeyChain을 사용해야 하는 이유는?",
                answer: """
                UserDefaults는 데이터를 평문(Plain Text) 형태의 plist 파일로 저장하므로, \
                탈옥된 기기나 특정 툴을 통해 쉽게 내용이 노출될 위험이 있어 단순한 설정값에 적합합니다. \
                반면 KeyChain은 데이터를 암호화하여 OS 내부의 안전한 공간에 저장하며, \
                앱을 삭제해도 데이터가 유지되도록 설정할 수 있어 \
                보안이 중요한 인증 토큰이나 비밀번호 저장에 필수적입니다.
                """,
                category: .networking
            ),
            InterviewCard(
                question: "SwiftData란 무엇이며 Core Data와 어떻게 다른가요?",
                answer: """
                SwiftData는 iOS 17에서 도입된 데이터 영속화 프레임워크로, \
                @Model 매크로를 붙이면 클래스가 자동으로 영속화 대상이 됩니다. \
                Core Data에 비해 보일러플레이트 코드가 크게 줄고, \
                SwiftUI의 @Query 프로퍼티 래퍼와 자연스럽게 통합되어 \
                데이터 변경 시 뷰가 자동으로 업데이트됩니다. \
                내부적으로 Core Data 기반 위에 구축되어 있어 마이그레이션도 지원합니다.
                """,
                category: .networking
            ),

            // MARK: - 기타

            InterviewCard(
                question: "Escaping Closure(@escaping)란 무엇이며, 주로 어떤 상황에서 사용되나요?",
                answer: """
                함수의 인자로 전달된 클로저가 함수 실행이 종료된 후에도 실행되어야 할 때 사용하는 키워드입니다. \
                주로 네트워크 요청과 같은 비동기 작업의 완료 콜백(Completion Handler)이나, \
                클로저를 외부 변수에 저장해두고 나중에 호출해야 하는 상황에서 필수적으로 사용됩니다.
                """,
                category: .swift
            ),
            InterviewCard(
                question: "프로토콜 초기 구현(Protocol Extension)이란 무엇이며, 어떤 이점이 있나요?",
                answer: """
                프로토콜은 기본적으로 기능의 '청사진(요구사항)'만 정의하지만, \
                extension을 사용하면 프로토콜 자체에 메서드나 프로퍼티의 기본 구현체를 제공할 수 있습니다. \
                여러 타입에서 동일한 기능 구현 시 코드 중복을 제거하고, \
                값 타입에도 상속 없이 다형성을 부여하며, \
                필요에 따라 자유롭게 오버라이딩하여 커스터마이징할 수 있습니다.
                """,
                category: .swift
            ),
            InterviewCard(
                question: "Core ML 모델을 사용할 때 앱 용량이나 메모리 측면에서의 최적화 방안은?",
                answer: """
                모델 파일 크기가 크면 앱 번들 용량이 커지므로, \
                가중치를 16비트나 8비트로 줄이는 양자화(Quantization)를 고려합니다. \
                실시간 추론 시 매 프레임마다 모델을 새로 로드하면 메모리와 배터리 소모가 심하므로, \
                모델 인스턴스를 한 번만 생성하여 재사용해야 합니다. \
                사용자가 해당 기능을 쓰는 시점에 백그라운드에서 모델을 컴파일하고 로드하는 \
                지연 로딩 방식을 적용할 수 있습니다.
                """,
                category: .swift
            ),
            InterviewCard(
                question: "옵저버 패턴(Observer Pattern)이란 무엇이며, iOS에서 어떻게 구현하나요?",
                answer: """
                객체의 상태 변화가 발생했을 때, 이를 관찰하고 있는(구독하는) 다른 객체들에게 \
                자동으로 알림을 보내는 패턴입니다. \
                iOS에서는 NotificationCenter나 KVO(Key-Value Observing)를 통해 구현해왔으며, \
                최근에는 Combine의 Publisher-Subscriber 모델이나 \
                SwiftUI의 @State, ObservableObject 등을 통해 직관적으로 구현할 수 있습니다.
                """,
                category: .architecture
            ),
            InterviewCard(
                question: "크로스 플랫폼(Flutter, React Native)과 비교해 네이티브 iOS 개발의 장점은?",
                answer: """
                네이티브 개발은 Apple이 제공하는 최신 API와 프레임워크에 즉시 접근 가능하여 \
                새로운 기능을 빠르게 도입할 수 있습니다. \
                하드웨어(카메라, AR, NFC 등)에 대한 직접 접근이 가능하고, \
                성능 최적화 여지가 크며, 플랫폼 고유의 UX를 자연스럽게 제공합니다. \
                디버깅과 프로파일링 도구(Instruments, Xcode Previews)가 강력합니다.
                """,
                category: .swift
            )
        ]

        sampleCards.forEach { context.insert($0) }
    }
}
// swiftlint:enable function_body_length type_body_length
