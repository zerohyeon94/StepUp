//
//  StepUpApp.swift
//  StepUp
//
//  Created by 조영현 on 3/4/26.
//

import SwiftUI
import SwiftData

@main
struct StepUpApp: App {
    @State private var appCoordinator = AppCoordinator()
    let modelContainer: ModelContainer

    init() {
        // 1. 컨테이너를 먼저 생성하여 상수에 할당합니다.
        let container = SwiftDataStack.createModelContainer()
        self.modelContainer = container
        
        // 2. self.modelContainer 대신 로컬 변수인 container를 사용합니다.
        Task { @MainActor in
            let context = container.mainContext
            SwiftDataStack.seedInitialData(context: context)
        }
    }

    var body: some Scene {
        WindowGroup {
            appCoordinator.start()
        }
        .modelContainer(modelContainer)
    }
}
