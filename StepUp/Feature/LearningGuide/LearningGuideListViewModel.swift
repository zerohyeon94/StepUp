//
//  LearningGuideListViewModel.swift
//  StepUp
//

import Observation

@Observable
@MainActor
final class LearningGuideListViewModel {
    private(set) var topics: [LearningTopic] = []

    func loadTopics() {
        topics = LearningGuideDataProvider.allTopics()
            .sorted { $0.order < $1.order }
    }
}
