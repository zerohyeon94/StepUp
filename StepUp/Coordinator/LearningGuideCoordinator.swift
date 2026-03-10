//
//  LearningGuideCoordinator.swift
//  StepUp
//

import SwiftUI
import Observation

@Observable
final class LearningGuideCoordinator: Coordinator {
    typealias Route = LearningGuideRoute

    var childCoordinators: [any Coordinator] = []
    var navigationPath = NavigationPath()

    func start() -> AnyView {
        AnyView(LearningGuideCoordinatorView(coordinator: self))
    }

    func showTopicDetail(topic: LearningTopic) {
        navigationPath.append(LearningGuideRoute.topicDetail(topic))
    }

    func pop() {
        guard !navigationPath.isEmpty else { return }
        navigationPath.removeLast()
    }

    func popToRoot() {
        navigationPath = NavigationPath()
    }
}
