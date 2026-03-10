//
//  GCDDemoViewModel.swift
//  StepUp
//
//  Created by 조영현 on 3/4/26.
//

import Foundation
import Observation

@Observable
@MainActor
final class GCDDemoViewModel {

    struct TaskInfo: Identifiable {
        let id = UUID()
        let name: String
        var isComplete: Bool
        var status: String
        var thread: String
    }

    var gcdTasks: [TaskInfo] = []
    var asyncTasks: [TaskInfo] = []
    var gcdDuration: TimeInterval?
    var asyncDuration: TimeInterval?
    var isGCDRunning = false
    var isAsyncRunning = false

    private var gcdStartTime: Date?
    private var asyncStartTime: Date?

    func runGCDTask() {
        guard !isGCDRunning else { return }
        isGCDRunning = true

        gcdTasks = (1...3).map {
            TaskInfo(name: "Task \($0)", isComplete: false, status: "대기중", thread: "-")
        }
        gcdDuration = nil
        gcdStartTime = Date()

        let group = DispatchGroup()

        for i in 0..<3 {
            group.enter()
            updateGCDTask(at: i, status: "실행중", thread: "global()")

            DispatchQueue.global().asyncAfter(deadline: .now() + Double.random(in: 0.5...2.0)) { [weak self] in
                let threadName = Thread.current.description
                DispatchQueue.main.async {
                    self?.completeGCDTask(at: i, thread: threadName)
                    group.leave()
                }
            }
        }

        group.notify(queue: .main) { [weak self] in
            guard let self, let start = gcdStartTime else { return }
            gcdDuration = Date().timeIntervalSince(start)
            isGCDRunning = false
        }
    }

    func runAsyncTask() async {
        guard !isAsyncRunning else { return }
        isAsyncRunning = true

        asyncTasks = (1...3).map {
            TaskInfo(name: "Task \($0)", isComplete: false, status: "대기중", thread: "-")
        }
        asyncDuration = nil
        asyncStartTime = Date()

        await withTaskGroup(of: Int.self) { group in
            for i in 0..<3 {
                group.addTask { [weak self] in
                    await MainActor.run {
                        self?.updateAsyncTask(at: i, status: "실행중", thread: "Task")
                    }
                    try? await Task.sleep(for: .milliseconds(Int.random(in: 500...2000)))
                    return i
                }
            }

            for await index in group {
                completeAsyncTask(at: index, thread: "MainActor")
            }
        }

        if let start = asyncStartTime {
            asyncDuration = Date().timeIntervalSince(start)
        }
        isAsyncRunning = false
    }

    func reset() {
        gcdTasks = []
        asyncTasks = []
        gcdDuration = nil
        asyncDuration = nil
    }

    private func updateGCDTask(at index: Int, status: String, thread: String) {
        guard index < gcdTasks.count else { return }
        gcdTasks[index].status = status
        gcdTasks[index].thread = thread
    }

    private func completeGCDTask(at index: Int, thread: String) {
        guard index < gcdTasks.count else { return }
        gcdTasks[index].isComplete = true
        gcdTasks[index].status = "완료"
        gcdTasks[index].thread = thread
    }

    private func updateAsyncTask(at index: Int, status: String, thread: String) {
        guard index < asyncTasks.count else { return }
        asyncTasks[index].status = status
        asyncTasks[index].thread = thread
    }

    private func completeAsyncTask(at index: Int, thread: String) {
        guard index < asyncTasks.count else { return }
        asyncTasks[index].isComplete = true
        asyncTasks[index].status = "완료"
        asyncTasks[index].thread = thread
    }
}
