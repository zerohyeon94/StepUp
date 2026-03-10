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

    init() {
        self.cardCoordinator = CardCoordinator()
        addChild(cardCoordinator)
    }

    func start() -> AnyView {
        AnyView(AppCoordinatorView(coordinator: self))
    }
}
