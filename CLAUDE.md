# CLAUDE.md — iOS Interview Flashcard App

> 이 파일은 Claude AI가 본 프로젝트를 이해하고 일관된 방식으로 코드를 작성하기 위한 가이드입니다.

---

## 프로젝트 개요

iOS 면접 준비를 위한 플래시카드 앱으로, 두 가지 핵심 기능을 제공합니다.

1. **면접 카드 뷰어** — 질문/답변을 카드 형식으로 탐색
2. **인터랙티브 미니 프로젝트** — 개념을 실제 동작으로 확인하는 내장 데모 화면

### 미니 프로젝트 예시

| 면접 질문 | 미니 프로젝트 데모 |
|---|---|
| iOS App 생명주기를 설명해보세요 | 실제 앱 상태 전환 시 알림 표시 (Foreground → Background → Suspended) |
| ARC(Automatic Reference Counting)란? | 객체 init/deinit을 시각적으로 표현하는 메모리 그래프 |
| RunLoop이란 무엇인가요? | RunLoop 이벤트 흐름을 실시간으로 시각화 |
| GCD와 async/await 차이점은? | 스레드 동작을 타임라인으로 비교 시각화 |

---

## 기술 스택

### UI 프레임워크 전략 (UIKit + SwiftUI 혼용)

본 프로젝트는 두 프레임워크를 **의도적으로 함께** 사용합니다.
실무에서 레거시 코드베이스와 신규 코드가 공존하는 환경을 학습하는 것이 목적입니다.

| 영역 | 프레임워크 | 이유 |
|---|---|---|
| 메인 카드 리스트 / 탐색 화면 | SwiftUI | 선언형 UI, 빠른 프로토타이핑 |
| 카드 플립 애니메이션 | SwiftUI | 애니메이션 API 활용 |
| 미니 프로젝트 데모 화면 | UIKit | 세밀한 레이아웃 제어, CALayer 직접 조작 |
| UIKit ↔ SwiftUI 브릿지 | UIViewControllerRepresentable / UIViewRepresentable | 두 프레임워크 연동 학습 |

```
// SwiftUI에서 UIKit 뷰 사용 예시
struct ArcDemoView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ArcDemoViewController {
        ArcDemoViewController()
    }
    func updateUIViewController(_ uiViewController: ArcDemoViewController, context: Context) {}
}
```

### 전체 스택

```
- Language:      Swift 5.10+
- iOS Target:    iOS 17+
- UI:            SwiftUI (주) + UIKit (미니 프로젝트 데모)
- Architecture:  MVVM + Coordinator
- Networking:    URLSession + async/await
- Persistence:   SwiftData
- DI:            Swift Dependencies (pointfreeco/swift-dependencies)
- Lint:          SwiftLint
```

---

## 아키텍처

### MVVM + Coordinator 구조

```
App
├── Coordinator
│   ├── AppCoordinator          # 루트 코디네이터
│   ├── CardCoordinator         # 카드 탐색 흐름
│   └── MiniProjectCoordinator  # 미니 프로젝트 흐름
│
├── Feature
│   ├── CardList
│   │   ├── CardListView.swift          (SwiftUI)
│   │   └── CardListViewModel.swift
│   ├── CardDetail
│   │   ├── CardDetailView.swift        (SwiftUI)
│   │   └── CardDetailViewModel.swift
│   └── MiniProjects
│       ├── AppLifecycle
│       │   ├── AppLifecycleDemoVC.swift       (UIKit)
│       │   └── AppLifecycleDemoViewModel.swift
│       ├── ARC
│       │   ├── ARCDemoVC.swift                (UIKit)
│       │   └── ARCDemoViewModel.swift
│       └── GCD
│           ├── GCDDemoView.swift              (SwiftUI)
│           └── GCDDemoViewModel.swift
│
├── Domain
│   ├── Models
│   │   ├── InterviewCard.swift
│   │   ├── CardCategory.swift
│   │   └── MiniProjectType.swift
│   └── UseCases
│       ├── FetchCardsUseCase.swift
│       └── BookmarkCardUseCase.swift
│
├── Data
│   ├── Repositories
│   │   └── CardRepository.swift
│   └── Persistence
│       └── SwiftDataStack.swift
│
└── Core
    ├── Extensions
    ├── Components          # 재사용 가능한 공통 뷰
    └── Theme               # 색상, 폰트 등 디자인 시스템
```

### Coordinator 패턴 규칙

```swift
// 모든 Coordinator는 이 프로토콜을 준수합니다
protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    func start()
}

// SwiftUI NavigationStack 기반 Coordinator 예시
@Observable
final class CardCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var path = NavigationPath()

    func start() { /* 초기 화면 설정 */ }
    func showDetail(card: InterviewCard) { path.append(card) }
    func showMiniProject(type: MiniProjectType) { /* 미니 프로젝트 push */ }
}
```

---

## 빌드 & 테스트 명령어

```bash
# 빌드
xcodebuild -scheme StepUp -sdk iphonesimulator build

# 테스트 실행
xcodebuild test -scheme StepUp \
  -destination 'platform=iOS Simulator,name=iPhone 16'

# 특정 테스트만 실행
xcodebuild test -scheme StepUp \
  -destination 'platform=iOS Simulator,name=iPhone 16' \
  -only-testing 'StepUpTests/InterviewCardTests'

# SwiftLint 실행
swiftlint

# SwiftLint 자동 수정
swiftlint --fix
```

---

## 코딩 컨벤션

### 공통 규칙

```swift
// ✅ 좋은 예: 옵셔널 안전하게 처리
guard let card = cards.first else { return }

// ❌ 금지: Force Unwrap
let card = cards.first!

// ✅ 좋은 예: async/await 사용
func fetchCards() async throws -> [InterviewCard] {
    try await cardRepository.fetchAll()
}

// ❌ 금지: 중첩 클로저 콜백 지옥
cardRepository.fetchAll { result in
    result.map { cards in ... }
}
```

### SwiftUI 규칙

```swift
// ✅ @StateObject: View가 직접 소유할 때
struct CardListView: View {
    @StateObject private var viewModel = CardListViewModel()
}

// ✅ @ObservedObject: 외부에서 주입받을 때
struct CardDetailView: View {
    @ObservedObject var viewModel: CardDetailViewModel
}

// ❌ 금지: View body에 비즈니스 로직 작성
var body: some View {
    // 금지: 여기서 데이터 필터링/가공하지 말 것
    let filtered = cards.filter { $0.category == .swift } // ❌
}

// ✅ 좋은 예: ViewModel에서 처리된 데이터 사용
var body: some View {
    List(viewModel.filteredCards) { card in
        CardRowView(card: card)
    }
}

// ❌ 금지: 거대한 View body
// body가 50줄 초과 시 반드시 서브뷰로 분리할 것
var body: some View {
    VStack { /* 200줄짜리 body */ } // ❌
}
```

### UIKit 규칙

```swift
// ✅ 좋은 예: 의존성 주입으로 ViewModel 전달
final class ARCDemoViewController: UIViewController {
    private let viewModel: ARCDemoViewModel

    init(viewModel: ARCDemoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    // ❌ 금지: Storyboard 사용 (코드 기반 UI만 허용)
    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError() }
}

// ✅ 좋은 예: Auto Layout을 코드로 작성
NSLayoutConstraint.activate([
    label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
    label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
])
```

### 네이밍 컨벤션

```swift
// View: 명사 + View / ViewController
CardListView, ARCDemoViewController

// ViewModel: 명사 + ViewModel
CardListViewModel, ARCDemoViewModel

// UseCase: 동사 + UseCase
FetchCardsUseCase, BookmarkCardUseCase

// Repository: 명사 + Repository
CardRepository

// Protocol: 형용사/명사 (접미사 없음 또는 able/ing)
Coordinator, CardRepositoryProtocol
```

---

## 미니 프로젝트 구현 가이드

미니 프로젝트 데모 화면을 추가할 때 반드시 아래 구조를 따릅니다.

```swift
// 1. MiniProjectType enum에 케이스 추가
enum MiniProjectType: String, CaseIterable {
    case appLifecycle = "App 생명주기"
    case arc          = "ARC"
    case gcd          = "GCD / async-await"
    // 새 데모 추가 시 여기에 케이스 추가
}

// 2. MiniProjectFactory에서 화면 생성 로직 추가
struct MiniProjectFactory {
    static func makeViewController(for type: MiniProjectType) -> UIViewController {
        switch type {
        case .appLifecycle: return AppLifecycleDemoViewController()
        case .arc:          return ARCDemoViewController()
        case .gcd:          return GCDDemoHostingController()
        }
    }
}
```

---

## SwiftData 모델

```swift
@Model
final class InterviewCard {
    var id: UUID
    var question: String
    var answer: String
    var category: CardCategory
    var isBookmarked: Bool
    var miniProjectType: MiniProjectType?  // nil이면 미니 프로젝트 없음
    var createdAt: Date

    init(question: String, answer: String, category: CardCategory) {
        self.id = UUID()
        self.question = question
        self.answer = answer
        self.category = category
        self.isBookmarked = false
        self.miniProjectType = nil
        self.createdAt = Date()
    }
}

enum CardCategory: String, Codable, CaseIterable {
    case swift       = "Swift"
    case uikit       = "UIKit"
    case swiftui     = "SwiftUI"
    case architecture = "아키텍처"
    case concurrency = "동시성"
    case memory      = "메모리"
    case networking  = "네트워킹"
}
```

---

## 주의사항 및 금지 사항

| 항목 | 금지 | 권장 |
|---|---|---|
| 옵셔널 처리 | `value!` (force unwrap) | `guard let` / `if let` / `??` |
| UI 구성 | Storyboard / XIB | 코드 기반 UI |
| View 로직 | body에 비즈니스 로직 | ViewModel로 분리 |
| 상태 관리 | 전역 변수 | DI + ViewModel |
| 비동기 처리 | 중첩 completion handler | async/await |
| View 크기 | 50줄 초과 body | 서브뷰로 분리 |

---

## 참고 문서

- [Swift 공식 문서](https://www.swift.org/documentation/)
- [SwiftUI 문서](https://developer.apple.com/documentation/swiftui)
- [UIKit 문서](https://developer.apple.com/documentation/uikit)
- [SwiftData 문서](https://developer.apple.com/documentation/swiftdata)
- [swift-dependencies](https://github.com/pointfreeco/swift-dependencies)
- [SwiftLint 규칙](https://realm.github.io/SwiftLint/rule-directory.html)
