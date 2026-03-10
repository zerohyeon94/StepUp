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
                    타입 뒤에 ?를 붙여 선언합니다. \
                    값이 없는 상태는 nil로 표현됩니다. \
                    다른 언어의 null/None과 비슷하지만, 컴파일 시점에 안전하게 처리할 수 있습니다.
                    """,
                    codeExample: """
                    var name: String? = "Swift"  // 값이 있음
                    var age: Int? = nil           // 값이 없음

                    // 옵셔널은 값을 직접 사용할 수 없음
                    // print(name.count)  // 컴파일 에러!
                    """
                ),
                LearningSection(
                    title: "옵셔널 바인딩 (if let, guard let)",
                    content: """
                    옵셔널 바인딩은 옵셔널에서 안전하게 값을 꺼내는 방법입니다. \
                    if let은 값이 있을 때 블록 안에서 사용하고, \
                    guard let은 값이 없으면 일찍 리턴하여 이후 코드에서 안전하게 사용합니다. \
                    guard let은 함수 내에서 조건을 빠르게 체크할 때 유용합니다.
                    """,
                    codeExample: """
                    // if let
                    if let unwrapped = name {
                        print("이름: \\(unwrapped)")
                    }

                    // guard let (함수 내에서)
                    func greet(_ name: String?) {
                        guard let name else { return }
                        print("안녕, \\(name)!")
                    }

                    // nil 병합 연산자
                    let displayName = name ?? "이름 없음"
                    """
                ),
                LearningSection(
                    title: "옵셔널 체이닝",
                    content: """
                    옵셔널 체이닝은 옵셔널 값의 프로퍼티나 메서드에 안전하게 접근하는 방법입니다. \
                    중간에 nil이 있으면 전체 표현식이 nil을 반환합니다. \
                    여러 단계의 옵셔널을 연쇄적으로 처리할 수 있어 코드가 깔끔해집니다.
                    """,
                    codeExample: """
                    struct Company {
                        var ceo: Person?
                    }

                    let company: Company? = Company(ceo: nil)

                    // 옵셔널 체이닝
                    let ceoName = company?.ceo?.name
                    // company가 nil이면 → nil
                    // ceo가 nil이면 → nil
                    // 둘 다 있으면 → name 값
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
                    func 키워드로 정의하며, 매개변수와 반환 타입을 지정할 수 있습니다. \
                    Swift 함수는 외부 매개변수 이름(Argument Label)과 \
                    내부 매개변수 이름(Parameter Name)을 구분할 수 있습니다.
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
                    func square(_ n: Int) -> Int {
                        n * n
                    }
                    square(5)  // 25
                    """
                ),
                LearningSection(
                    title: "클로저 (Closure)",
                    content: """
                    클로저는 이름이 없는 함수입니다. \
                    { (매개변수) -> 반환타입 in 본문 } 형태로 작성합니다. \
                    변수에 할당하거나 함수의 인자로 전달할 수 있습니다. \
                    주변 환경의 값을 캡처(Capture)할 수 있습니다. \
                    Swift에서는 후행 클로저, 타입 추론 등으로 간결하게 작성할 수 있습니다.
                    """,
                    codeExample: """
                    // 기본 클로저
                    let add = { (a: Int, b: Int) -> Int in
                        return a + b
                    }

                    // 후행 클로저 + 축약
                    let numbers = [3, 1, 4, 1, 5]
                    let sorted = numbers.sorted { $0 < $1 }

                    // map, filter, reduce
                    let doubled = numbers.map { $0 * 2 }
                    let evens = numbers.filter { $0 % 2 == 0 }
                    let sum = numbers.reduce(0) { $0 + $1 }
                    """
                ),
                LearningSection(
                    title: "@escaping 클로저",
                    content: """
                    함수가 종료된 후에도 실행될 수 있는 클로저를 @escaping 클로저라고 합니다. \
                    비동기 작업(네트워크 요청 등)에서 주로 사용됩니다. \
                    클로저가 self를 캡처할 때 메모리 관리에 주의해야 합니다. \
                    [weak self]를 사용하여 강한 참조 순환을 방지합니다.
                    """,
                    codeExample: """
                    func fetchData(completion: @escaping (String) -> Void) {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            completion("데이터 로드 완료")
                        }
                    }

                    // weak self로 순환 참조 방지
                    class MyVC: UIViewController {
                        func load() {
                            fetchData { [weak self] result in
                                self?.updateUI(with: result)
                            }
                        }
                    }
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
                    프로토콜은 특정 역할을 수행하기 위해 필요한 메서드나 프로퍼티의 '약속'입니다. \
                    클래스, 구조체, 열거형 모두 프로토콜을 채택(conform)할 수 있습니다. \
                    Java의 인터페이스와 비슷하지만, Swift 프로토콜은 기본 구현을 제공할 수 있습니다.
                    """,
                    codeExample: """
                    protocol Drawable {
                        var color: String { get }
                        func draw()
                    }

                    struct Circle: Drawable {
                        var color: String
                        func draw() {
                            print("원 그리기: \\(color)")
                        }
                    }
                    """
                ),
                LearningSection(
                    title: "프로토콜 확장 (Extension)",
                    content: """
                    프로토콜 확장을 통해 기본 구현(Default Implementation)을 제공할 수 있습니다. \
                    채택하는 타입이 해당 메서드를 구현하지 않으면 기본 구현이 사용됩니다. \
                    이를 '프로토콜 지향 프로그래밍(POP)'이라 하며, \
                    Swift의 핵심 프로그래밍 패러다임입니다.
                    """,
                    codeExample: """
                    protocol Greetable {
                        var name: String { get }
                        func greet() -> String
                    }

                    extension Greetable {
                        func greet() -> String {  // 기본 구현
                            "안녕, \\(name)!"
                        }
                    }

                    struct User: Greetable {
                        var name: String
                        // greet() 구현 안 해도 OK (기본 구현 사용)
                    }
                    """
                ),
                LearningSection(
                    title: "자주 쓰는 프로토콜",
                    content: """
                    Identifiable: 고유 id 프로퍼티 요구. SwiftUI의 List, ForEach에서 필수입니다. \
                    Codable: JSON 인코딩/디코딩을 위한 프로토콜입니다. \
                    Equatable: == 비교를 가능하게 합니다. \
                    Hashable: 딕셔너리 키나 Set의 요소로 사용할 수 있게 합니다.
                    """,
                    codeExample: """
                    struct Movie: Identifiable, Codable, Hashable {
                        let id: UUID
                        let title: String
                        let year: Int
                    }

                    // Codable: JSON 변환
                    let json = try JSONEncoder().encode(movie)
                    let decoded = try JSONDecoder().decode(
                        Movie.self, from: json
                    )
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
                    body 프로퍼티에 화면에 표시할 내용을 선언합니다. \
                    body는 'some View'를 반환하며, 이는 하나의 뷰를 의미합니다. \
                    여러 뷰를 배치하려면 VStack, HStack, ZStack 등의 컨테이너를 사용합니다.
                    """,
                    codeExample: """
                    struct ContentView: View {
                        var body: some View {
                            VStack {
                                Text("Hello, World!")
                                    .font(.title)
                                Image(systemName: "star.fill")
                                    .foregroundStyle(.yellow)
                            }
                        }
                    }
                    """
                ),
                LearningSection(
                    title: "레이아웃 (Stack, List)",
                    content: """
                    VStack은 세로 배치, HStack은 가로 배치, ZStack은 겹치기입니다. \
                    spacing으로 간격을, alignment로 정렬을 제어합니다. \
                    List는 스크롤 가능한 목록을 만듭니다. \
                    padding, frame 등의 수정자(modifier)로 크기와 여백을 조절합니다.
                    """,
                    codeExample: """
                    VStack(alignment: .leading, spacing: 16) {
                        Text("제목")
                            .font(.headline)

                        HStack {
                            Image(systemName: "person")
                            Text("사용자")
                        }

                        List(items) { item in
                            Text(item.name)
                        }
                    }
                    .padding()
                    """
                ),
                LearningSection(
                    title: "버튼과 사용자 입력",
                    content: """
                    Button은 탭 이벤트를 처리하는 기본 컴포넌트입니다. \
                    TextField는 텍스트 입력, Toggle은 스위치, Slider는 범위 입력에 사용됩니다. \
                    NavigationStack과 NavigationLink로 화면 간 이동을 구현합니다.
                    """,
                    codeExample: """
                    Button("탭하세요") {
                        print("버튼 눌림!")
                    }
                    .buttonStyle(.borderedProminent)

                    TextField("이름 입력", text: $name)
                        .textFieldStyle(.roundedBorder)

                    Toggle("알림 허용", isOn: $isOn)
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
                    값이 변경되면 SwiftUI가 자동으로 화면을 다시 그립니다. \
                    주로 간단한 값 타입(Int, String, Bool 등)에 사용합니다. \
                    private으로 선언하는 것이 권장됩니다.
                    """,
                    codeExample: """
                    struct CounterView: View {
                        @State private var count = 0

                        var body: some View {
                            VStack {
                                Text("카운트: \\(count)")
                                Button("증가") {
                                    count += 1  // 화면 자동 업데이트
                                }
                            }
                        }
                    }
                    """
                ),
                LearningSection(
                    title: "@Binding",
                    content: """
                    @Binding은 부모 뷰의 @State를 자식 뷰에서 읽고 쓸 수 있게 하는 연결고리입니다. \
                    자식 뷰가 값을 소유하지 않고, 부모의 값을 참조합니다. \
                    $를 붙여 바인딩을 전달합니다.
                    """,
                    codeExample: """
                    struct ParentView: View {
                        @State private var isOn = false

                        var body: some View {
                            ToggleView(isOn: $isOn)  // $ 로 바인딩 전달
                        }
                    }

                    struct ToggleView: View {
                        @Binding var isOn: Bool      // 부모의 값을 참조

                        var body: some View {
                            Toggle("스위치", isOn: $isOn)
                        }
                    }
                    """
                ),
                LearningSection(
                    title: "@Observable과 ViewModel",
                    content: """
                    iOS 17+에서 @Observable 매크로를 사용하면 클래스의 프로퍼티 변경을 \
                    SwiftUI가 자동으로 감지합니다. \
                    ViewModel 패턴에서 비즈니스 로직을 View에서 분리할 때 사용합니다. \
                    View의 body에는 UI 코드만, 데이터 처리는 ViewModel에 작성합니다.
                    """,
                    codeExample: """
                    @Observable
                    class TodoViewModel {
                        var items: [String] = []

                        func addItem(_ text: String) {
                            items.append(text)
                        }
                    }

                    struct TodoView: View {
                        @State private var viewModel = TodoViewModel()

                        var body: some View {
                            List(viewModel.items, id: \\.self) {
                                Text($0)
                            }
                        }
                    }
                    """
                )
            ]
        )
    }
}
// swiftlint:enable function_body_length type_body_length
