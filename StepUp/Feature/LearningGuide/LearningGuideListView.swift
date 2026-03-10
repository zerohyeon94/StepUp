//
//  LearningGuideListView.swift
//  StepUp
//

import SwiftUI

struct LearningGuideListView: View {
    @State private var viewModel = LearningGuideListViewModel()
    let coordinator: LearningGuideCoordinator

    var body: some View {
        List {
            ForEach(viewModel.topics) { topic in
                LearningGuideTopicRowView(topic: topic)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        coordinator.showTopicDetail(topic: topic)
                    }
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("학습 가이드")
        .task {
            viewModel.loadTopics()
        }
    }
}
