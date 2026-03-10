//
//  CardCoordinator.swift
//  StepUp
//
//  Created by 조영현 on 3/4/26.
//

import SwiftUI
import Observation

@Observable
final class CardCoordinator: Coordinator {
    typealias Route = CardRoute

    var childCoordinators: [any Coordinator] = []
    var navigationPath = NavigationPath()

    func start() -> AnyView {
        AnyView(CardCoordinatorView(coordinator: self))
    }

    func showDetail(card: InterviewCard) {
        navigationPath.append(CardRoute.detail(card))
    }

    func showMiniProject(type: MiniProjectType) {
        navigationPath.append(CardRoute.miniProject(type))
    }

    func pop() {
        guard !navigationPath.isEmpty else { return }
        navigationPath.removeLast()
    }

    func popToRoot() {
        navigationPath = NavigationPath()
    }
}
