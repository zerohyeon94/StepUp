//
//  LearningGuideCoordinatorView.swift
//  StepUp
//

import SwiftUI

struct LearningGuideCoordinatorView: View {
    @Bindable var coordinator: LearningGuideCoordinator

    var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            LearningGuideListView(coordinator: coordinator)
                .navigationDestination(for: LearningGuideRoute.self) { route in
                    destinationView(for: route)
                }
        }
    }

    @ViewBuilder
    private func destinationView(for route: LearningGuideRoute) -> some View {
        switch route {
        case .list:
            LearningGuideListView(coordinator: coordinator)
        case .topicDetail(let topic):
            LearningGuideTopicDetailView(topic: topic)
        }
    }
}
