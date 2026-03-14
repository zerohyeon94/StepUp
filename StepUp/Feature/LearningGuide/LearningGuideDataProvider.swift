//
//  LearningGuideDataProvider.swift
//  StepUp
//

import SwiftUI

// swiftlint:disable function_body_length type_body_length
enum LearningGuideDataProvider {
    static func allTopics() -> [LearningTopic] {
        [
            swiftBasics,
            objectOriented,
            optionals,
            functionsAndClosures,
            protocols,
            swiftUIBasics,
            stateManagement
        ]
    }

    // MARK: - 1. Swift 언어 기초

    private static var swiftBasics: LearningTopic {
        LearningTopic(
            order: 1,
            title: "Swift 언어 기초",
            subtitle: "변수/상수, 데이터 타입, 제어문",
            iconName: "swift",
            color: .orange,
            sections: [
                LearningSection(
                    title: "변수와 상수 (var, let)",
                    content: """
                    var는 값을 변경할 수 있는 변수, let은 한 번 할당하면 변경할 수 없는 상수입니다.

                    Swift에서는 변경할 필요가 없는 값은 항상 let으로 선언하는 것이 권장됩니다. \
                    Xcode도 var로 선언했지만 값을 변경하지 않으면 let으로 바꾸라고 경고합니다. \
                    let을 사용하면 컴파일러가 최적화할 수 있고, 의도치 않은 값 변경을 방지합니다.

                    타입 어노테이션은 콜론(:) 뒤에 타입을 명시하는 것입니다. \
                    초기값이 있으면 생략 가능하지만, 초기값 없이 선언할 때는 반드시 필요합니다.

                    Swift의 네이밍 규칙은 camelCase입니다. \
                    변수/상수/함수는 소문자로 시작(myName), 타입은 대문자로 시작(MyClass)합니다.

                    문자열 보간법(String Interpolation)으로 변수 값을 문자열에 삽입할 수 있습니다. \
                    \\(변수명) 형태로 사용합니다.
                    """,
                    codeExample: """
                    // 기본 선언
                    let name = "Swift"    // 상수: 변경 불가
                    var age = 5           // 변수: 변경 가능
                    age = 6               // OK
                    // name = "Kotlin"    // 컴파일 에러!

                    // 타입 어노테이션
                    let height: Double = 175.5
                    var score: Int       // 초기값 없이 선언 (타입 필수)
                    score = 100          // 나중에 할당

                    // 여러 변수 한 줄에 선언
                    var x = 0, y = 0, z = 0

                    // 문자열 보간법
                    let greeting = "\\(name)는 \\(age)살입니다"
                    // → "Swift는 6살입니다"
                    """
                ),
                LearningSection(
                    title: "기본 데이터 타입",
                    content: """
                    Swift의 기본 타입으로는 Int(정수), Double(실수), String(문자열), Bool(참/거짓)이 있습니다. \
                    Swift는 타입 추론을 지원하여 초기값을 보고 타입을 자동으로 결정하지만, \
                    명시적으로 타입을 지정할 수도 있습니다.

                    컬렉션 타입으로 Array(순서가 있는 목록), Dictionary(키-값 쌍), Set(중복 없는 집합)이 있습니다.

                    튜플(Tuple)은 여러 값을 하나로 묶을 때 사용합니다. \
                    함수에서 여러 값을 반환할 때 특히 유용합니다.

                    타입 변환은 Int(), String(), Double() 등의 이니셜라이저로 수행합니다. \
                    Swift는 암시적 타입 변환을 허용하지 않아, 항상 명시적으로 변환해야 합니다.
                    """,
                    codeExample: """
                    // 기본 타입
                    let score: Int = 100
                    let pi: Double = 3.14
                    let greeting: String = "안녕하세요"
                    let isActive: Bool = true

                    // 타입 추론
                    let count = 42        // Int로 추론
                    let message = "Hello" // String으로 추론

                    // 컬렉션 타입
                    var fruits: [String] = ["사과", "바나나"]  // Array
                    fruits.append("딸기")

                    var ages: [String: Int] = ["Kim": 25]     // Dictionary
                    ages["Lee"] = 30

                    var colors: Set<String> = ["빨강", "파랑"] // Set (중복 불가)

                    // 튜플
                    let person = (name: "Kim", age: 25)
                    print(person.name)  // "Kim"

                    // 타입 변환 (명시적)
                    let num = 42
                    let text = String(num)    // "42"
                    let pi2 = Double(num)     // 42.0
                    // let wrong: Double = num // 컴파일 에러!
                    """
                ),
                LearningSection(
                    title: "제어문 (if, switch, for, while)",
                    content: """
                    if문은 조건에 따라 코드를 분기합니다. \
                    Swift의 if문에서 조건은 반드시 Bool 타입이어야 합니다(C처럼 0/1 사용 불가).

                    guard문은 조건이 거짓이면 함수를 조기 종료합니다. \
                    if와 반대로 "이 조건을 만족하지 않으면 나가라"는 의미입니다. \
                    guard let으로 옵셔널을 풀면 이후 코드에서 안전하게 사용할 수 있습니다.

                    switch문은 강력한 패턴 매칭을 지원합니다. \
                    C/Java와 달리 break가 자동으로 적용되고, 모든 경우를 처리해야 합니다(exhaustive). \
                    where절로 추가 조건을 걸 수 있습니다.

                    범위 연산자: 1...5는 1부터 5까지(닫힌 범위), 1..<5는 1부터 4까지(반열린 범위)입니다.

                    for-in 반복문은 배열, 범위, 딕셔너리, 문자열 등을 순회합니다. \
                    while은 조건이 true인 동안, repeat-while은 최소 1회 실행 후 조건을 검사합니다.

                    반복문에서 continue는 현재 반복을 건너뛰고, break는 반복을 완전히 종료합니다.
                    """,
                    codeExample: """
                    // if문
                    if score >= 90 {
                        print("A등급")
                    } else if score >= 80 {
                        print("B등급")
                    }

                    // guard문 (조기 종료)
                    func process(value: Int?) {
                        guard let value else {
                            print("값이 없습니다")
                            return
                        }
                        // 여기서 value는 안전하게 사용 가능
                        print("값: \\(value)")
                    }

                    // switch + where절
                    switch score {
                    case 90...100:            print("A")
                    case 80..<90:             print("B")
                    case let x where x >= 70: print("C (\\(x)점)")
                    default:                  print("F")
                    }

                    // for-in (배열, 범위, 딕셔너리)
                    for i in 1...5 { print(i) }

                    for (key, val) in ages {
                        print("\\(key): \\(val)")
                    }

                    // repeat-while (최소 1회 실행)
                    var n = 0
                    repeat {
                        n += 1
                    } while n < 3

                    // continue, break
                    for i in 1...10 {
                        if i % 2 == 0 { continue } // 짝수 건너뛰기
                        if i > 7 { break }          // 7 초과 시 종료
                        print(i)  // 1, 3, 5, 7
                    }
                    """
                )
            ]
        )
    }

    // MARK: - 2. 객체지향의 3대장

    private static var objectOriented: LearningTopic {
        LearningTopic(
            order: 2,
            title: "객체지향의 3대장",
            subtitle: "Class, Struct, Enum",
            iconName: "cube.box",
            color: .blue,
            sections: [
                LearningSection(
                    title: "클래스 (Class)",
                    content: """
                    클래스는 참조 타입(Reference Type)입니다. \
                    변수에 할당하거나 함수에 전달할 때 값이 복사되지 않고 같은 인스턴스를 참조합니다.

                    클래스만의 특징:
                    - 상속(Inheritance): 부모 클래스의 프로퍼티와 메서드를 물려받을 수 있습니다.
                    - deinit(소멸자): 인스턴스가 메모리에서 해제될 때 호출됩니다.
                    - ARC(자동 참조 카운팅)로 메모리가 관리됩니다.
                    - 참조 비교(===): 두 변수가 같은 인스턴스를 가리키는지 확인합니다.

                    상속 시 override 키워드로 부모의 메서드를 재정의합니다. \
                    super로 부모의 원래 구현을 호출할 수 있습니다. \
                    final 키워드를 붙이면 더 이상 상속하거나 재정의할 수 없습니다.
                    """,
                    codeExample: """
                    class Animal {
                        var name: String
                        init(name: String) { self.name = name }

                        func speak() -> String { "..." }
                    }

                    // 상속
                    class Dog: Animal {
                        override func speak() -> String {
                            "멍멍! 나는 \\(name)"
                        }
                    }

                    // final: 상속/재정의 금지
                    final class Cat: Animal {
                        override func speak() -> String { "야옹" }
                    }

                    // 참조 타입 동작
                    let a = Dog(name: "뽀삐")
                    let b = a        // 같은 인스턴스를 참조
                    b.name = "콩이"  // a.name도 "콩이"로 변경됨

                    // 참조 비교 (===)
                    print(a === b)   // true (같은 인스턴스)
                    let c = Dog(name: "콩이")
                    print(a === c)   // false (다른 인스턴스)
                    """
                ),
                LearningSection(
                    title: "구조체 (Struct)",
                    content: """
                    구조체는 값 타입(Value Type)입니다. \
                    변수에 할당하거나 함수에 전달할 때 값이 복사됩니다. \
                    상속이 불가능하지만, 프로토콜 채택은 가능합니다.

                    멤버와이즈 이니셜라이저가 자동으로 생성되어 편리합니다. \
                    커스텀 init을 작성하면 멤버와이즈 이니셜라이저는 사라집니다. \
                    (extension에 커스텀 init을 넣으면 둘 다 유지할 수 있습니다.)

                    Apple은 대부분의 경우 구조체 사용을 권장합니다:
                    - 상속이 필요 없을 때
                    - 데이터의 크기가 작을 때
                    - 값이 복사되는 것이 자연스러울 때
                    - 여러 스레드에서 안전하게 사용하고 싶을 때

                    Swift의 Array, String, Dictionary도 모두 구조체입니다. \
                    내부적으로 Copy-on-Write(COW) 최적화가 적용되어, \
                    실제로 값이 변경될 때만 복사가 일어나므로 성능 걱정이 적습니다.
                    """,
                    codeExample: """
                    struct Point {
                        var x: Double
                        var y: Double
                        // 멤버와이즈 init 자동 생성
                    }

                    var p1 = Point(x: 0, y: 0)
                    var p2 = p1      // 값이 복사됨
                    p2.x = 10        // p1.x는 여전히 0

                    // Struct vs Class 선택 기준
                    // ✅ Struct: 좌표, 크기, 색상, 설정값 등
                    struct Size {
                        var width: Double
                        var height: Double
                    }

                    // ✅ Class: 화면 컨트롤러, 네트워크 매니저 등
                    //   (고유 정체성이 있고 공유되어야 하는 객체)

                    // extension에 커스텀 init → 멤버와이즈도 유지
                    extension Point {
                        init(value: Double) {
                            self.x = value
                            self.y = value
                        }
                    }
                    let p3 = Point(value: 5)     // 커스텀 init
                    let p4 = Point(x: 1, y: 2)   // 멤버와이즈도 OK
                    """
                ),
                LearningSection(
                    title: "열거형 (Enum)",
                    content: """
                    열거형은 관련된 값들의 그룹을 정의합니다. \
                    Swift의 enum은 매우 강력하여 다른 언어와 차별화됩니다.

                    원시 값(Raw Value): 각 케이스에 고정된 값을 부여합니다. \
                    String, Int 등의 타입을 사용할 수 있습니다.

                    연관 값(Associated Value): 각 케이스에 서로 다른 타입의 데이터를 첨부합니다. \
                    네트워크 결과(성공/실패)처럼 케이스마다 다른 데이터가 필요할 때 유용합니다.

                    enum에 메서드와 연산 프로퍼티를 정의할 수 있습니다. \
                    CaseIterable 프로토콜을 채택하면 모든 케이스를 배열로 순회할 수 있습니다.

                    switch문에서 enum을 사용하면 모든 케이스를 처리해야 합니다(exhaustive). \
                    if case let 문법으로 특정 케이스만 간단히 체크할 수도 있습니다.
                    """,
                    codeExample: """
                    // 기본 열거형
                    enum Direction {
                        case north, south, east, west
                    }

                    // 원시 값 (Raw Value)
                    enum Planet: Int {
                        case mercury = 1
                        case venus   // 자동으로 2
                        case earth   // 자동으로 3
                    }
                    let earth = Planet(rawValue: 3)  // Optional

                    // 연관 값 (Associated Value)
                    enum NetworkResult {
                        case success(data: Data)
                        case failure(message: String)
                    }

                    // 연관 값 꺼내기
                    let result: NetworkResult = .failure(message: "404")
                    if case let .failure(msg) = result {
                        print("에러: \\(msg)")
                    }

                    // CaseIterable: 모든 케이스 순회
                    enum Season: String, CaseIterable {
                        case spring = "봄", summer = "여름"
                        case fall = "가을", winter = "겨울"
                    }
                    for s in Season.allCases {
                        print(s.rawValue)  // 봄, 여름, 가을, 겨울
                    }

                    // enum에 메서드 정의
                    enum Coin: Int {
                        case penny = 1, nickel = 5, dime = 10

                        func krw() -> Int {
                            self.rawValue * 13  // 원화 환산
                        }
                    }
                    """
                ),
                LearningSection(
                    title: "프로퍼티와 메서드",
                    content: """
                    프로퍼티는 타입에 연관된 값입니다.

                    저장 프로퍼티(Stored Property): 값을 직접 저장합니다. \
                    lazy 키워드를 붙이면 처음 접근할 때까지 초기화를 미룹니다(지연 초기화).

                    연산 프로퍼티(Computed Property): 값을 저장하지 않고 매번 계산합니다. \
                    get만 있으면 읽기 전용, set도 있으면 읽기/쓰기가 가능합니다.

                    프로퍼티 옵저버(willSet/didSet): 저장 프로퍼티의 값이 변경될 때 호출됩니다. \
                    willSet은 변경 직전, didSet은 변경 직후에 실행됩니다.

                    타입 프로퍼티/메서드: static 키워드를 붙이면 인스턴스가 아닌 타입 자체에 속합니다. \
                    클래스에서 class 키워드를 쓰면 자식 클래스가 override할 수 있습니다.

                    구조체에서 프로퍼티를 변경하는 메서드는 mutating 키워드가 필요합니다.
                    """,
                    codeExample: """
                    struct Circle {
                        var radius: Double            // 저장 프로퍼티
                        lazy var description = "원"   // 지연 초기화

                        var area: Double {            // 연산 프로퍼티 (get only)
                            .pi * radius * radius
                        }

                        mutating func scale(by factor: Double) {
                            radius *= factor           // mutating 필요
                        }

                        // 타입 프로퍼티 & 메서드
                        static let unit = Circle(radius: 1.0)
                        static func compare(_ a: Circle, _ b: Circle) -> Bool {
                            a.radius < b.radius
                        }
                    }

                    // 프로퍼티 옵저버
                    class StepCounter {
                        var steps: Int = 0 {
                            willSet {
                                print("곧 \\(newValue)로 변경됩니다")
                            }
                            didSet {
                                let diff = steps - oldValue
                                print("\\(diff)걸음 추가됨!")
                            }
                        }
                    }

                    let counter = StepCounter()
                    counter.steps = 100
                    // "곧 100로 변경됩니다"
                    // "100걸음 추가됨!"
                    """
                ),
                LearningSection(
                    title: "인스턴스 (Instance)",
                    content: """
                    클래스, 구조체, 열거형은 '설계도'이고, 인스턴스는 그 설계도로 만든 '실제 객체'입니다. \
                    예를 들어 Person 클래스가 설계도라면, Person(name: "Kim")으로 만든 것이 인스턴스입니다.

                    이니셜라이저(init): 인스턴스를 생성할 때 호출되는 특별한 메서드입니다. \
                    모든 프로퍼티에 초기값을 할당해야 합니다.

                    Designated Init: 클래스의 주된 이니셜라이저로, 모든 프로퍼티를 직접 초기화합니다. \
                    Convenience Init: 보조 이니셜라이저로, 내부에서 반드시 designated init을 호출합니다. \
                    convenience 키워드를 붙여 구분합니다.

                    self: 인스턴스 자기 자신을 가리킵니다. \
                    매개변수와 프로퍼티 이름이 같을 때 구분하기 위해 self.을 사용합니다.

                    deinit: 클래스 인스턴스가 메모리에서 해제될 때 호출되는 소멸자입니다. \
                    구조체와 열거형에는 deinit이 없습니다.

                    인스턴스 멤버 vs 타입 멤버: \
                    인스턴스 프로퍼티/메서드는 각 인스턴스마다 고유하고, \
                    타입 프로퍼티/메서드(static)는 타입 전체가 공유합니다.
                    """,
                    codeExample: """
                    class User {
                        let id: Int
                        var name: String
                        var email: String

                        // Designated Init (주 이니셜라이저)
                        init(id: Int, name: String, email: String) {
                            self.id = id       // self로 프로퍼티와 매개변수 구분
                            self.name = name
                            self.email = email
                        }

                        // Convenience Init (보조 이니셜라이저)
                        convenience init(name: String) {
                            self.init(
                                id: Int.random(in: 1...9999),
                                name: name,
                                email: "\\(name)@example.com"
                            )
                        }

                        deinit {
                            print("\\(name) 메모리 해제")
                        }

                        // 인스턴스 메서드 (각 인스턴스마다 다른 결과)
                        func greet() -> String {
                            "안녕, 나는 \\(name)"
                        }

                        // 타입 메서드 (타입 자체에서 호출)
                        static var totalCount = 0
                        static func printCount() {
                            print("총 \\(totalCount)명")
                        }
                    }

                    // 인스턴스 생성
                    let user1 = User(name: "Kim")            // convenience
                    let user2 = User(id: 1, name: "Lee",     // designated
                                     email: "lee@test.com")

                    user1.greet()        // 인스턴스 메서드
                    User.printCount()    // 타입 메서드
                    """
                )
            ]
        )
    }

    // MARK: - 3. 옵셔널

    private static var optionals: LearningTopic {
        LearningTopic(
            order: 3,
            title: "옵셔널 (Optional)",
            subtitle: "값의 존재 여부를 안전하게 처리",
            iconName: "questionmark.diamond",
            color: .purple,
            sections: [
                LearningSection(
                    title: "옵셔널이란?",
                    content: """
                    옵셔널은 '값이 있을 수도 있고 없을 수도 있음'을 표현하는 Swift의 핵심 타입입니다. \
                    타입 뒤에 ?를 붙여 선언하며, 값이 없는 상태는 nil로 표현됩니다.

                    Swift가 옵셔널을 도입한 이유: 다른 언어에서는 null 참조로 인한 크래시가 빈번합니다. \
                    Swift는 컴파일 시점에 nil 가능성을 강제로 처리하게 하여 런타임 크래시를 방지합니다.

                    내부적으로 Optional은 enum입니다. \
                    Optional<String>은 .some("값") 또는 .none(nil) 두 가지 상태를 가집니다. \
                    String?은 Optional<String>의 축약 표현입니다.

                    암시적 언래핑 옵셔널(IUO): 타입 뒤에 !를 붙여 선언합니다. \
                    접근할 때 자동으로 언래핑되지만, nil이면 크래시가 발생합니다. \
                    IBOutlet 등 초기화 직후 반드시 값이 있는 경우에만 사용합니다.
                    """,
                    codeExample: """
                    var name: String? = "Swift"  // 값이 있음
                    var age: Int? = nil           // 값이 없음

                    // 옵셔널은 값을 직접 사용할 수 없음
                    // print(name.count)  // 컴파일 에러!

                    // Optional은 사실 enum
                    let greeting: Optional<String> = .some("안녕")
                    let empty: Optional<String> = .none  // nil과 동일

                    // switch로 옵셔널 처리
                    switch name {
                    case .some(let value):
                        print("값: \\(value)")
                    case .none:
                        print("값 없음")
                    }

                    // 암시적 언래핑 옵셔널 (IUO)
                    var label: String! = "제목"
                    print(label.count)  // 자동 언래핑 (nil이면 크래시!)
                    """
                ),
                LearningSection(
                    title: "옵셔널 바인딩 (if let, guard let)",
                    content: """
                    옵셔널 바인딩은 옵셔널에서 안전하게 값을 꺼내는 방법입니다.

                    if let: 값이 있을 때만 블록 안에서 사용합니다. \
                    Swift 5.7부터 if let name 처럼 같은 이름으로 축약할 수 있습니다.

                    guard let: 값이 없으면 함수를 조기 종료(return)합니다. \
                    언래핑된 값을 이후 코드 전체에서 사용할 수 있어 들여쓰기가 줄어듭니다.

                    nil 병합 연산자(??): 옵셔널이 nil이면 기본값을 사용합니다.

                    여러 옵셔널을 쉼표(,)로 동시에 바인딩할 수 있습니다. \
                    하나라도 nil이면 전체가 실패합니다.

                    옵셔널의 map/flatMap: 값이 있을 때만 변환을 적용합니다. \
                    map은 변환 결과를 옵셔널로 감싸고, flatMap은 이중 옵셔널을 풀어줍니다.
                    """,
                    codeExample: """
                    // if let (기본)
                    if let unwrapped = name {
                        print("이름: \\(unwrapped)")
                    }

                    // Swift 5.7+ 축약 문법
                    if let name {
                        print("이름: \\(name)")  // 같은 이름으로 바로 사용
                    }

                    // guard let (함수 내에서)
                    func greet(_ name: String?) {
                        guard let name else { return }
                        // 이후 코드에서 name을 안전하게 사용
                        print("안녕, \\(name)!")
                    }

                    // 여러 옵셔널 동시 바인딩
                    let firstName: String? = "Kim"
                    let lastName: String? = "Swift"
                    if let first = firstName, let last = lastName {
                        print("\\(first) \\(last)")  // 둘 다 있을 때만
                    }

                    // nil 병합 연산자 (??)
                    let displayName = name ?? "이름 없음"

                    // 옵셔널 map
                    let length: Int? = name.map { $0.count }
                    // name이 nil이면 → nil
                    // name이 "Swift"면 → Optional(5)
                    """
                ),
                LearningSection(
                    title: "옵셔널 체이닝",
                    content: """
                    옵셔널 체이닝은 옵셔널 값의 프로퍼티나 메서드에 ?. 으로 안전하게 접근하는 방법입니다. \
                    중간에 nil이 있으면 전체 표현식이 nil을 반환하고, 나머지 체인은 실행되지 않습니다.

                    중요: 옵셔널 체이닝의 결과는 항상 옵셔널입니다. \
                    원래 프로퍼티가 비옵셔널이더라도 체이닝을 거치면 옵셔널이 됩니다.

                    메서드 호출에도 옵셔널 체이닝을 사용할 수 있습니다. \
                    nil이면 메서드가 호출되지 않고, 있으면 정상 실행됩니다.

                    서브스크립트, 프로퍼티 할당에도 체이닝이 가능합니다. \
                    실전에서는 중첩된 모델 구조에서 깊은 값을 안전하게 꺼낼 때 자주 사용합니다.
                    """,
                    codeExample: """
                    struct Address {
                        var city: String
                    }
                    struct Person {
                        var name: String
                        var address: Address?

                        func introduce() -> String {
                            "저는 \\(name)입니다"
                        }
                    }
                    struct Company {
                        var ceo: Person?
                    }

                    let company: Company? = Company(
                        ceo: Person(name: "Kim", address: nil)
                    )

                    // 프로퍼티 체이닝
                    let ceoName = company?.ceo?.name       // Optional("Kim")
                    let ceoCity = company?.ceo?.address?.city  // nil

                    // 메서드 호출 체이닝
                    let intro = company?.ceo?.introduce()   // Optional("저는 Kim입니다")

                    // 체이닝 + nil 병합
                    let city = company?.ceo?.address?.city ?? "주소 없음"

                    // 체이닝으로 값 할당 (nil이면 무시됨)
                    company?.ceo?.address?.city = "서울"
                    """
                )
            ]
        )
    }

    // MARK: - 4. 함수와 클로저

    private static var functionsAndClosures: LearningTopic {
        LearningTopic(
            order: 4,
            title: "함수와 클로저",
            subtitle: "코드를 묶어 실행하는 방법",
            iconName: "function",
            color: .green,
            sections: [
                LearningSection(
                    title: "함수 기본",
                    content: """
                    함수는 특정 작업을 수행하는 코드 블록입니다. \
                    func 키워드로 정의하며, 매개변수와 반환 타입을 지정할 수 있습니다.

                    Swift 함수의 특징:
                    - Argument Label(외부 이름)과 Parameter Name(내부 이름)을 구분합니다.
                    - _로 외부 이름을 생략할 수 있습니다.
                    - 기본값(Default Value)을 지정하면 호출 시 생략 가능합니다.
                    - 가변 매개변수(Variadic)는 ...으로 여러 값을 받습니다.
                    - inout 매개변수는 함수 안에서 원본 값을 직접 변경합니다.

                    튜플을 사용하면 여러 값을 한 번에 반환할 수 있습니다.

                    Swift의 함수는 1급 시민(First-class Citizen)입니다. \
                    변수에 할당하거나, 다른 함수의 인자로 전달할 수 있습니다. \
                    함수 타입은 (매개변수 타입) -> 반환 타입으로 표현합니다.
                    """,
                    codeExample: """
                    // 기본 함수
                    func greet(name: String) -> String {
                        return "안녕, \\(name)!"
                    }

                    // Argument Label 사용
                    func move(from start: Int, to end: Int) {
                        print("\\(start)에서 \\(end)로 이동")
                    }
                    move(from: 0, to: 10)

                    // Argument Label 생략 (_)
                    func square(_ n: Int) -> Int { n * n }
                    square(5)  // 25

                    // 기본값 매개변수
                    func greet(_ name: String, emoji: String = "👋") {
                        print("\\(emoji) \\(name)")
                    }
                    greet("Kim")              // 👋 Kim
                    greet("Lee", emoji: "🎉") // 🎉 Lee

                    // 가변 매개변수 (Variadic)
                    func sum(_ numbers: Int...) -> Int {
                        numbers.reduce(0, +)
                    }
                    sum(1, 2, 3, 4, 5)  // 15

                    // inout: 원본 값 변경
                    func doubleIt(_ value: inout Int) {
                        value *= 2
                    }
                    var num = 10
                    doubleIt(&num)  // num = 20 (&를 붙여 전달)

                    // 여러 값 반환 (튜플)
                    func minMax(_ arr: [Int]) -> (min: Int, max: Int) {
                        (arr.min()!, arr.max()!)
                    }
                    let result = minMax([3, 1, 5])
                    print(result.min)  // 1

                    // 함수 타입
                    let operation: (Int, Int) -> Int = { $0 + $1 }
                    """
                ),
                LearningSection(
                    title: "클로저 (Closure)",
                    content: """
                    클로저는 이름이 없는 함수입니다. \
                    { (매개변수) -> 반환타입 in 본문 } 형태로 작성합니다.

                    클로저는 1급 시민으로 변수에 할당하거나 함수 인자로 전달할 수 있습니다.

                    Swift에서 클로저 축약 과정:
                    1단계: 전체 형태 → { (a: Int, b: Int) -> Bool in return a < b }
                    2단계: 타입 추론 → { a, b in return a < b }
                    3단계: 단일 표현식 return 생략 → { a, b in a < b }
                    4단계: 축약 인자($0, $1) → { $0 < $1 }

                    후행 클로저(Trailing Closure): 마지막 매개변수가 클로저면 소괄호 밖에 작성합니다.

                    값 캡처(Capture): 클로저는 주변 환경의 변수를 참조로 캡처합니다. \
                    캡처된 변수는 원래 범위가 끝나도 클로저가 살아있는 한 유지됩니다.

                    자주 쓰는 고차 함수: map(변환), filter(필터링), reduce(합산), \
                    compactMap(nil 제거 + 변환), flatMap(중첩 배열 평탄화).
                    """,
                    codeExample: """
                    // 클로저 축약 과정
                    let numbers = [3, 1, 4, 1, 5]

                    // 전체 형태
                    numbers.sorted(by: { (a: Int, b: Int) -> Bool in
                        return a < b
                    })
                    // 최종 축약
                    numbers.sorted { $0 < $1 }

                    // 후행 클로저
                    let sorted = numbers.sorted { $0 < $1 }

                    // map, filter, reduce
                    let doubled = numbers.map { $0 * 2 }       // [6,2,8,2,10]
                    let evens = numbers.filter { $0 % 2 == 0 } // [4]
                    let sum = numbers.reduce(0) { $0 + $1 }    // 14

                    // compactMap: nil 제거 + 변환
                    let strings = ["1", "two", "3", "four"]
                    let nums = strings.compactMap { Int($0) }  // [1, 3]

                    // 값 캡처
                    func makeCounter() -> () -> Int {
                        var count = 0
                        return {
                            count += 1  // count를 캡처 (참조)
                            return count
                        }
                    }
                    let counter = makeCounter()
                    counter()  // 1
                    counter()  // 2 (count가 유지됨)
                    """
                ),
                LearningSection(
                    title: "@escaping 클로저",
                    content: """
                    @escaping: 함수가 종료된 후에도 실행될 수 있는 클로저입니다. \
                    비동기 작업(네트워크, 타이머 등)의 콜백에서 주로 사용됩니다. \
                    클로저를 프로퍼티에 저장하거나 다른 함수에 전달할 때도 필요합니다.

                    non-escaping(기본값): 함수 종료 전에 반드시 실행됩니다. \
                    @escaping을 명시하지 않으면 자동으로 non-escaping입니다. \
                    컴파일러가 메모리를 더 효율적으로 관리할 수 있습니다.

                    @escaping 클로저에서 self를 캡처하면 강한 참조 순환이 발생할 수 있습니다. \
                    [weak self]로 약한 참조를 사용하여 메모리 누수를 방지합니다. \
                    guard let self else { return } 패턴으로 안전하게 사용합니다.

                    @autoclosure: 표현식을 자동으로 클로저로 감쌉니다. \
                    assert()처럼 조건이 참일 때 인자를 평가하지 않는 지연 평가에 유용합니다.
                    """,
                    codeExample: """
                    // @escaping: 함수 종료 후 실행
                    func fetchData(completion: @escaping (String) -> Void) {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            completion("데이터 로드 완료")
                        }
                    }

                    // weak self 패턴 (메모리 누수 방지)
                    class ProfileVC: UIViewController {
                        var name = "Kim"

                        func load() {
                            fetchData { [weak self] result in
                                guard let self else { return }
                                // self가 해제되었으면 여기서 종료
                                print("\\(self.name): \\(result)")
                            }
                        }
                    }

                    // 프로퍼티에 클로저 저장 (@escaping 필요)
                    class Button {
                        var onTap: (() -> Void)?

                        func setAction(_ action: @escaping () -> Void) {
                            self.onTap = action  // 저장 → @escaping
                        }
                    }

                    // @autoclosure
                    func log(_ message: @autoclosure () -> String) {
                        print(message())  // 호출 시점에 평가
                    }
                    log("현재 시각: \\(Date())")  // {}없이 사용 가능
                    """
                )
            ]
        )
    }

    // MARK: - 5. 프로토콜

    private static var protocols: LearningTopic {
        LearningTopic(
            order: 5,
            title: "프로토콜 (Protocol)",
            subtitle: "역할의 약속과 규약",
            iconName: "doc.plaintext",
            color: .teal,
            sections: [
                LearningSection(
                    title: "프로토콜이란?",
                    content: """
                    프로토콜은 특정 역할을 수행하기 위해 필요한 메서드나 프로퍼티의 '약속(청사진)'입니다. \
                    클래스, 구조체, 열거형 모두 프로토콜을 채택(conform)할 수 있습니다.

                    Java의 인터페이스와 비슷하지만, Swift 프로토콜은 기본 구현을 제공할 수 있어 더 강력합니다.

                    프로퍼티 요구사항: { get }은 읽기만, { get set }은 읽기/쓰기를 요구합니다. \
                    실제 구현에서 저장 프로퍼티든 연산 프로퍼티든 상관없습니다.

                    프로토콜 합성(&): 여러 프로토콜을 동시에 요구할 수 있습니다. \
                    함수 매개변수에서 Codable & Hashable처럼 사용합니다.

                    AnyObject를 상속하면 클래스만 채택할 수 있는 프로토콜이 됩니다. \
                    weak 참조가 필요한 delegate 패턴에서 자주 사용합니다.
                    """,
                    codeExample: """
                    protocol Drawable {
                        var color: String { get }       // 읽기 전용
                        var lineWidth: Double { get set } // 읽기+쓰기
                        func draw()
                    }

                    struct Circle: Drawable {
                        var color: String
                        var lineWidth: Double
                        func draw() {
                            print("\\(lineWidth)pt \\(color) 원 그리기")
                        }
                    }

                    // 프로토콜 합성 (&)
                    func save(_ item: Codable & Identifiable) {
                        // Codable이면서 Identifiable인 타입만 받음
                    }

                    // 클래스 전용 프로토콜 (delegate 패턴)
                    protocol ViewDelegate: AnyObject {
                        func didTapButton()
                    }

                    class MyView {
                        weak var delegate: ViewDelegate?  // weak 가능
                    }
                    """
                ),
                LearningSection(
                    title: "프로토콜 확장 (Extension)",
                    content: """
                    프로토콜 확장을 통해 기본 구현(Default Implementation)을 제공할 수 있습니다. \
                    채택하는 타입이 해당 메서드를 구현하지 않으면 기본 구현이 사용됩니다.

                    이것이 '프로토콜 지향 프로그래밍(POP)'의 핵심입니다. \
                    클래스 상속 없이도 코드를 공유할 수 있어, 구조체와 열거형에서도 활용 가능합니다. \
                    다이아몬드 상속 문제(다중 상속의 충돌)가 발생하지 않습니다.

                    where절로 조건부 확장이 가능합니다. \
                    특정 타입이 다른 프로토콜을 만족할 때만 기능을 추가할 수 있습니다. \
                    예: Array의 Element가 Numeric일 때만 sum() 메서드 추가.

                    기존 타입에 프로토콜 채택을 추가하는 것도 가능합니다(소급 모델링). \
                    extension Int: CustomProtocol 처럼 기존 타입을 확장합니다.
                    """,
                    codeExample: """
                    protocol Greetable {
                        var name: String { get }
                        func greet() -> String
                    }

                    // 기본 구현 제공
                    extension Greetable {
                        func greet() -> String {
                            "안녕, \\(name)!"
                        }
                    }

                    struct User: Greetable {
                        var name: String
                        // greet() 구현 안 해도 OK (기본 구현 사용)
                    }

                    struct VIPUser: Greetable {
                        var name: String
                        func greet() -> String {
                            "환영합니다, \\(name)님!"  // 재정의
                        }
                    }

                    // where절: 조건부 확장
                    extension Array where Element: Numeric {
                        func sum() -> Element {
                            reduce(0, +)
                        }
                    }
                    [1, 2, 3].sum()        // 6 (Int는 Numeric)
                    // ["a", "b"].sum()     // 컴파일 에러 (String은 Numeric 아님)

                    // 기존 타입에 프로토콜 채택 추가
                    extension Int: Greetable {
                        var name: String { "숫자 \\(self)" }
                    }
                    42.greet()  // "안녕, 숫자 42!"
                    """
                ),
                LearningSection(
                    title: "자주 쓰는 프로토콜",
                    content: """
                    Swift 표준 라이브러리와 iOS SDK에서 자주 사용하는 프로토콜들입니다.

                    Identifiable: 고유 id 프로퍼티 요구. SwiftUI의 List, ForEach에서 필수입니다.

                    Codable: Encodable + Decodable의 조합. JSON 인코딩/디코딩에 사용합니다. \
                    프로퍼티 이름이 JSON 키와 다르면 CodingKeys enum으로 매핑합니다.

                    Equatable: == 비교를 가능하게 합니다. \
                    모든 프로퍼티가 Equatable이면 자동 합성됩니다.

                    Comparable: <, >, <=, >= 비교와 정렬이 가능해집니다.

                    Hashable: Dictionary 키나 Set 요소로 사용할 수 있게 합니다. \
                    Equatable을 포함합니다.

                    CustomStringConvertible: description 프로퍼티로 \
                    print() 출력 형식을 커스텀합니다.
                    """,
                    codeExample: """
                    struct Movie: Identifiable, Codable, Hashable {
                        let id: UUID
                        let title: String
                        let year: Int
                    }

                    // Codable: JSON 변환
                    let movie = Movie(id: UUID(), title: "기생충", year: 2019)
                    let json = try JSONEncoder().encode(movie)
                    let decoded = try JSONDecoder().decode(
                        Movie.self, from: json
                    )

                    // CodingKeys: JSON 키 이름 매핑
                    struct User: Codable {
                        let name: String
                        let profileURL: String

                        enum CodingKeys: String, CodingKey {
                            case name
                            case profileURL = "profile_url"  // 스네이크케이스 매핑
                        }
                    }

                    // Comparable: 정렬 가능
                    struct Score: Comparable {
                        let value: Int
                        static func < (lhs: Score, rhs: Score) -> Bool {
                            lhs.value < rhs.value
                        }
                    }
                    [Score(value: 3), Score(value: 1)].sorted()

                    // CustomStringConvertible
                    extension Movie: CustomStringConvertible {
                        var description: String {
                            "\\(title) (\\(year))"
                        }
                    }
                    print(movie)  // "기생충 (2019)"
                    """
                )
            ]
        )
    }

    // MARK: - 6. UI 화면 그리기

    private static var swiftUIBasics: LearningTopic {
        LearningTopic(
            order: 6,
            title: "UI 화면 그리기",
            subtitle: "SwiftUI로 화면 구성",
            iconName: "square.grid.2x2",
            color: .indigo,
            sections: [
                LearningSection(
                    title: "View 프로토콜과 body",
                    content: """
                    SwiftUI에서 모든 화면 요소는 View 프로토콜을 채택합니다. \
                    body 프로퍼티에 화면에 표시할 내용을 선언적으로 작성합니다.

                    some View는 Opaque Return Type으로, 구체적인 뷰 타입을 숨깁니다. \
                    컴파일러가 실제 타입을 알고 있어 성능에 영향이 없습니다. \
                    AnyView로 타입을 지우는 것은 성능이 떨어지므로 피하는 것이 좋습니다.

                    @ViewBuilder: body는 암시적으로 @ViewBuilder가 적용되어 \
                    여러 뷰를 나열할 수 있습니다. \
                    if/else, switch 등 조건부 뷰도 작성할 수 있습니다.

                    수정자(Modifier): .font(), .foregroundStyle() 등으로 뷰를 꾸밉니다. \
                    수정자는 새로운 뷰를 반환하므로 순서가 중요합니다.

                    서브뷰 분리: body가 복잡해지면 별도의 뷰 구조체로 분리합니다. \
                    computed property나 함수로 분리하는 것보다 별도 struct가 권장됩니다.
                    """,
                    codeExample: """
                    struct ContentView: View {
                        let isLoggedIn: Bool

                        var body: some View {
                            VStack(spacing: 12) {
                                Text("Hello, World!")
                                    .font(.title)
                                    .bold()
                                Image(systemName: "star.fill")
                                    .foregroundStyle(.yellow)
                                    .font(.largeTitle)

                                // 조건부 뷰 (@ViewBuilder)
                                if isLoggedIn {
                                    Text("환영합니다!")
                                } else {
                                    Button("로그인") { }
                                }
                            }
                            .padding()
                        }
                    }

                    // 서브뷰 분리 (권장)
                    struct StarBadge: View {
                        let count: Int

                        var body: some View {
                            HStack {
                                Image(systemName: "star.fill")
                                Text("\\(count)")
                            }
                            .foregroundStyle(.yellow)
                        }
                    }

                    // 수정자 순서가 중요!
                    Text("Hello")
                        .padding()            // 1. 안쪽 여백
                        .background(.blue)    // 2. 여백 포함 배경
                        .cornerRadius(8)      // 3. 모서리 둥글게
                    """
                ),
                LearningSection(
                    title: "레이아웃 (Stack, List)",
                    content: """
                    Stack 레이아웃:
                    - VStack: 세로 배치
                    - HStack: 가로 배치
                    - ZStack: 겹쳐서 배치 (뒤에서 앞으로)
                    spacing으로 간격을, alignment로 정렬을 제어합니다.

                    Spacer: 남은 공간을 차지하여 뷰를 밀어냅니다.

                    ScrollView: 콘텐츠가 화면을 넘을 때 스크롤을 가능하게 합니다. \
                    .vertical(기본) 또는 .horizontal 방향을 지정합니다.

                    LazyVStack/LazyHStack: 화면에 보이는 항목만 렌더링합니다. \
                    많은 데이터를 표시할 때 성능이 훨씬 좋습니다.

                    List: UIKit의 UITableView에 해당합니다. \
                    스크롤, 재사용, 스와이프 삭제 등이 기본 내장되어 있습니다.

                    overlay/background: 뷰 위에 겹치거나 뒤에 배경을 추가합니다. \
                    ZStack보다 특정 뷰에 종속된 레이어링에 적합합니다.

                    frame: 뷰의 크기를 지정합니다. \
                    .infinity로 가능한 최대 크기를 차지하게 할 수 있습니다.
                    """,
                    codeExample: """
                    // Stack + Spacer
                    HStack {
                        Text("왼쪽")
                        Spacer()          // 남은 공간 차지
                        Text("오른쪽")
                    }

                    // ScrollView + LazyVStack (성능 최적화)
                    ScrollView {
                        LazyVStack(spacing: 8) {
                            ForEach(items) { item in
                                Text(item.name)
                                    .frame(maxWidth: .infinity) // 최대 너비
                                    .padding()
                                    .background(.gray.opacity(0.1))
                                    .cornerRadius(8)
                            }
                        }
                        .padding()
                    }

                    // List (스와이프 삭제 포함)
                    List {
                        ForEach(items) { item in
                            Text(item.name)
                        }
                        .onDelete { indexSet in
                            items.remove(atOffsets: indexSet)
                        }
                    }
                    .listStyle(.insetGrouped)

                    // overlay: 뱃지 붙이기
                    Image(systemName: "bell")
                        .overlay(alignment: .topTrailing) {
                            Circle()
                                .fill(.red)
                                .frame(width: 8, height: 8)
                        }
                    """
                ),
                LearningSection(
                    title: "버튼과 사용자 입력",
                    content: """
                    Button: 탭 이벤트를 처리하는 기본 컴포넌트입니다. \
                    .borderedProminent, .bordered 등의 스타일을 적용할 수 있습니다.

                    TextField: 텍스트 입력 필드. $를 붙여 @State와 바인딩합니다. \
                    Toggle: ON/OFF 스위치. Slider: 범위 내 값 선택. \
                    Picker: 여러 선택지 중 하나를 고르는 컴포넌트입니다.

                    NavigationStack: iOS 16+ 화면 이동의 기본 컨테이너입니다. \
                    NavigationLink로 다음 화면을 push하고, 자동으로 뒤로가기 버튼이 생깁니다. \
                    .navigationTitle()로 타이틀을 설정합니다.

                    .sheet(): 아래에서 올라오는 모달 화면입니다. \
                    .fullScreenCover(): 전체 화면을 덮는 모달입니다.

                    .alert(): 경고 대화상자를 표시합니다. \
                    .confirmationDialog(): 액션 시트(하단 선택지)를 표시합니다.
                    """,
                    codeExample: """
                    struct InputDemoView: View {
                        @State private var name = ""
                        @State private var isOn = false
                        @State private var selected = "사과"
                        @State private var showSheet = false
                        @State private var showAlert = false
                        let fruits = ["사과", "바나나", "딸기"]

                        var body: some View {
                            NavigationStack {
                                Form {
                                    // 텍스트 입력
                                    TextField("이름 입력", text: $name)

                                    // 토글
                                    Toggle("알림 허용", isOn: $isOn)

                                    // 피커
                                    Picker("과일", selection: $selected) {
                                        ForEach(fruits, id: \\.self) {
                                            Text($0)
                                        }
                                    }

                                    // 버튼
                                    Button("시트 열기") {
                                        showSheet = true
                                    }
                                    .buttonStyle(.borderedProminent)

                                    // 화면 이동
                                    NavigationLink("상세 화면") {
                                        Text("상세 내용")
                                    }
                                }
                                .navigationTitle("입력 데모")
                                .sheet(isPresented: $showSheet) {
                                    Text("모달 화면")
                                }
                                .alert("확인", isPresented: $showAlert) {
                                    Button("확인") { }
                                    Button("취소", role: .cancel) { }
                                }
                            }
                        }
                    }
                    """
                )
            ]
        )
    }

    // MARK: - 7. 상태 관리

    private static var stateManagement: LearningTopic {
        LearningTopic(
            order: 7,
            title: "상태 관리",
            subtitle: "State, Binding 개념",
            iconName: "arrow.triangle.2.circlepath",
            color: .red,
            sections: [
                LearningSection(
                    title: "@State",
                    content: """
                    @State는 뷰가 직접 소유하고 관리하는 상태입니다. \
                    값이 변경되면 SwiftUI가 자동으로 body를 다시 계산하여 화면을 업데이트합니다.

                    SwiftUI의 View는 struct(값 타입)이므로, 일반 프로퍼티는 변경할 수 없습니다. \
                    @State는 실제 값을 SwiftUI 프레임워크가 별도로 관리하도록 하여 \
                    뷰가 재생성되더라도 값이 유지됩니다.

                    @State는 private으로 선언하는 것이 권장됩니다. \
                    해당 뷰만 소유하고 관리하는 상태이기 때문입니다.

                    일반 var 프로퍼티와의 차이: \
                    일반 var는 뷰가 재생성될 때마다 초기값으로 리셋됩니다. \
                    @State는 SwiftUI가 값을 보존하므로 사용자 인터랙션에 의한 변경이 유지됩니다.

                    주로 간단한 값 타입(Int, String, Bool 등)에 사용합니다. \
                    복잡한 모델은 @Observable 클래스로 분리하는 것이 좋습니다.
                    """,
                    codeExample: """
                    struct CounterView: View {
                        @State private var count = 0
                        @State private var text = ""
                        @State private var isExpanded = false

                        var body: some View {
                            VStack(spacing: 16) {
                                // 카운터
                                Text("카운트: \\(count)")
                                    .font(.largeTitle)
                                HStack {
                                    Button("-") { count -= 1 }
                                    Button("+") { count += 1 }
                                }

                                // 텍스트 입력
                                TextField("입력", text: $text)
                                Text("입력값: \\(text)")

                                // 토글 애니메이션
                                Button("토글") {
                                    withAnimation {
                                        isExpanded.toggle()
                                    }
                                }
                                if isExpanded {
                                    Text("펼쳐진 내용")
                                        .transition(.slide)
                                }
                            }
                        }
                    }

                    // ❌ 일반 var는 뷰 재생성 시 리셋됨
                    // var count = 0  // 버튼 눌러도 항상 0
                    """
                ),
                LearningSection(
                    title: "@Binding",
                    content: """
                    @Binding은 부모 뷰의 @State를 자식 뷰에서 읽고 쓸 수 있게 하는 연결고리입니다. \
                    자식 뷰가 값을 소유하지 않고, 부모의 값을 양방향으로 참조합니다.

                    $를 붙여 바인딩을 전달합니다. \
                    @State var count → $count가 Binding<Int> 타입입니다.

                    .constant(): 미리보기(Preview)나 테스트에서 고정된 바인딩을 만듭니다. \
                    값이 변경되지 않는 읽기 전용 바인딩입니다.

                    커스텀 바인딩: Binding(get:set:)으로 직접 만들 수 있습니다. \
                    값을 변환하거나 부수 효과를 추가할 때 유용합니다.

                    @Binding은 private으로 선언하지 않습니다. \
                    외부에서 주입받아야 하므로 접근 제어자를 붙이지 않습니다.
                    """,
                    codeExample: """
                    // 부모 → 자식 바인딩 전달
                    struct ParentView: View {
                        @State private var volume = 50.0

                        var body: some View {
                            VStack {
                                Text("볼륨: \\(Int(volume))")
                                VolumeSlider(value: $volume)  // $ 바인딩
                            }
                        }
                    }

                    struct VolumeSlider: View {
                        @Binding var value: Double  // 부모 값 참조

                        var body: some View {
                            Slider(value: $value, in: 0...100)
                        }
                    }

                    // Preview에서 .constant 사용
                    #Preview {
                        VolumeSlider(value: .constant(75))
                    }

                    // 커스텀 바인딩
                    struct FilterView: View {
                        @State private var rawText = ""

                        var uppercasedBinding: Binding<String> {
                            Binding(
                                get: { rawText.uppercased() },
                                set: { rawText = $0 }
                            )
                        }

                        var body: some View {
                            TextField("입력", text: uppercasedBinding)
                        }
                    }
                    """
                ),
                LearningSection(
                    title: "@Observable과 ViewModel",
                    content: """
                    iOS 17+에서 @Observable 매크로를 사용하면 클래스의 프로퍼티 변경을 \
                    SwiftUI가 자동으로 감지합니다. 별도의 Published 래퍼가 필요 없습니다.

                    MVVM 패턴의 흐름:
                    1. View: 화면을 그리고 사용자 입력을 받음
                    2. ViewModel: 비즈니스 로직과 데이터 가공
                    3. Model: 데이터 구조 정의
                    View → ViewModel에 액션 전달 → 데이터 변경 → View 자동 업데이트

                    @Observable vs ObservableObject(이전 방식):
                    - @Observable: iOS 17+, 프로퍼티마다 자동 추적, @Published 불필요
                    - ObservableObject: iOS 13+, @Published 명시 필요, @StateObject로 소유

                    @Environment: 앱 전체에서 공유하는 데이터를 주입합니다. \
                    상위 뷰에서 .environment()로 전달하면 하위 뷰 어디서든 접근 가능합니다. \
                    ViewModel, 설정값, 테마 등을 전달할 때 유용합니다.
                    """,
                    codeExample: """
                    // @Observable ViewModel (iOS 17+)
                    @Observable
                    class TodoViewModel {
                        var items: [String] = []
                        var newItemText = ""

                        var isEmpty: Bool { items.isEmpty }

                        func addItem() {
                            guard !newItemText.isEmpty else { return }
                            items.append(newItemText)
                            newItemText = ""
                        }

                        func removeItem(at index: Int) {
                            items.remove(at: index)
                        }
                    }

                    // View (UI만 담당)
                    struct TodoView: View {
                        @State private var viewModel = TodoViewModel()

                        var body: some View {
                            NavigationStack {
                                List {
                                    ForEach(viewModel.items, id: \\.self) {
                                        Text($0)
                                    }
                                    .onDelete { offsets in
                                        offsets.forEach {
                                            viewModel.removeItem(at: $0)
                                        }
                                    }
                                }
                                .overlay {
                                    if viewModel.isEmpty {
                                        Text("할 일을 추가하세요")
                                    }
                                }
                                .toolbar {
                                    TextField("새 항목", text:
                                        $viewModel.newItemText)
                                    Button("추가") {
                                        viewModel.addItem()
                                    }
                                }
                            }
                        }
                    }

                    // @Environment로 주입
                    @Observable class AppSettings {
                        var isDarkMode = false
                    }

                    // 상위 뷰에서 주입
                    // ContentView()
                    //     .environment(AppSettings())

                    // 하위 뷰에서 사용
                    struct SettingsView: View {
                        @Environment(AppSettings.self) var settings
                        var body: some View {
                            Toggle("다크 모드", isOn:
                                Bindable(settings).isDarkMode)
                        }
                    }
                    """
                )
            ]
        )
    }
}
// swiftlint:enable function_body_length type_body_length
