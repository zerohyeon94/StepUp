//
//  CardCoordinatorView.swift
//  StepUp
//
//  Created by 조영현 on 3/4/26.
//

import SwiftUI

struct CardCoordinatorView: View {
    @Bindable var coordinator: CardCoordinator

    var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            CardListView(coordinator: coordinator)
                .navigationDestination(for: CardRoute.self) { route in
                    destinationView(for: route)
                }
        }
    }

    @ViewBuilder
    private func destinationView(for route: CardRoute) -> some View {
        switch route {
        case .list:
            CardListView(coordinator: coordinator)
        case .detail(let card):
            CardDetailView(card: card, coordinator: coordinator)
        case .miniProject(let type):
            MiniProjectContainerView(type: type)
        }
    }
}
