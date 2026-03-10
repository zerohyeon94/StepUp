//
//  AppCoordinatorView.swift
//  StepUp
//
//  Created by 조영현 on 3/4/26.
//

import SwiftUI

struct AppCoordinatorView: View {
    @Bindable var coordinator: AppCoordinator

    var body: some View {
        TabView(selection: $coordinator.selectedTab) {
            coordinator.cardCoordinator.start()
                .tabItem {
                    Label("카드", systemImage: "rectangle.stack")
                }
                .tag(AppRoute.cards)

            coordinator.learningGuideCoordinator.start()
                .tabItem {
                    Label("학습 가이드", systemImage: "book")
                }
                .tag(AppRoute.learningGuide)

            SettingsView()
                .tabItem {
                    Label("설정", systemImage: "gear")
                }
                .tag(AppRoute.settings)
        }
    }
}

// MARK: - Settings Placeholder

private struct SettingsView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("앱 정보") {
                    LabeledContent("버전", value: "1.0.0")
                }
            }
            .navigationTitle("설정")
        }
    }
}
