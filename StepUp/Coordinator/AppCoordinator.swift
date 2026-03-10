//
//  AppCoordinator.swift
//  StepUp
//
//  Created by 조영현 on 3/4/26.
//

import SwiftUI
import Observation

@Observable
final class AppCoordinator: Coordinator {
    typealias Route = AppRoute

    var childCoordinators: [any Coordinator] = []
    var selectedTab: AppRoute = .cards

    private(set) var cardCoordinator: CardCoordinator
    private(set) var learningGuideCoordinator: LearningGuideCoordinator

    init() {
        self.cardCoordinator = CardCoordinator()
        self.learningGuideCoordinator = LearningGuideCoordinator()
        addChild(cardCoordinator)
        addChild(learningGuideCoordinator)
    }

    func start() -> AnyView {
        AnyView(AppCoordinatorView(coordinator: self))
    }
}
