//
//  GCDDemoView.swift
//  StepUp
//
//  Created by 조영현 on 3/4/26.
//

import SwiftUI

struct GCDDemoView: View {
    @State private var viewModel = GCDDemoViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Text("GCD vs async/await 비교")
                    .font(.title2.bold())

                Text("두 방식으로 동시에 3개의 작업을 실행하고 결과를 비교합니다")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)

                // GCD Section
                DemoSection(title: "GCD (Grand Central Dispatch)", color: .blue) {
                    Button {
                        viewModel.runGCDTask()
                    } label: {
                        HStack {
                            Image(systemName: "play.fill")
                            Text("GCD로 작업 실행")
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(viewModel.isGCDRunning)

                    TaskTimelineView(tasks: viewModel.gcdTasks, color: .blue)

                    if let duration = viewModel.gcdDuration {
                        Text("완료 시간: \(String(format: "%.2f", duration))초")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }

                // async/await Section
                DemoSection(title: "async/await (Swift Concurrency)", color: .green) {
                    Button {
                        Task {
                            await viewModel.runAsyncTask()
                        }
                    } label: {
                        HStack {
                            Image(systemName: "play.fill")
                            Text("async/await로 작업 실행")
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                    .disabled(viewModel.isAsyncRunning)

                    TaskTimelineView(tasks: viewModel.asyncTasks, color: .green)

                    if let duration = viewModel.asyncDuration {
                        Text("완료 시간: \(String(format: "%.2f", duration))초")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }

                // Comparison
                if viewModel.gcdDuration != nil || viewModel.asyncDuration != nil {
                    ComparisonView(
                        gcdDuration: viewModel.gcdDuration,
                        asyncDuration: viewModel.asyncDuration
                    )
                }

                Button {
                    viewModel.reset()
                } label: {
                    Text("초기화")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
            }
            .padding()
        }
    }
}

// MARK: - Demo Section

private struct DemoSection<Content: View>: View {
    let title: String
    let color: Color
    @ViewBuilder let content: () -> Content

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Circle()
                    .fill(color)
                    .frame(width: 8, height: 8)
                Text(title)
                    .font(.headline)
            }

            content()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

// MARK: - Task Timeline View

private struct TaskTimelineView: View {
    let tasks: [GCDDemoViewModel.TaskInfo]
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(tasks) { task in
                HStack {
                    Circle()
                        .fill(task.isComplete ? color : Color.orange)
                        .frame(width: 10, height: 10)

                    Text(task.name)
                        .font(.subheadline)

                    Spacer()

                    Text(task.status)
                        .font(.caption)
                        .foregroundStyle(task.isComplete ? .green : .orange)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(
                            (task.isComplete ? Color.green : Color.orange).opacity(0.1)
                        )
                        .clipShape(Capsule())
                }
            }
        }
    }
}

// MARK: - Comparison View

private struct ComparisonView: View {
    let gcdDuration: TimeInterval?
    let asyncDuration: TimeInterval?

    var body: some View {
        VStack(spacing: 12) {
            Text("실행 시간 비교")
                .font(.headline)

            HStack(spacing: 24) {
                VStack {
                    Text("GCD")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    if let gcd = gcdDuration {
                        Text("\(String(format: "%.2f", gcd))s")
                            .font(.title2.bold())
                            .foregroundStyle(.blue)
                    } else {
                        Text("-")
                            .font(.title2)
                            .foregroundStyle(.secondary)
                    }
                }

                Text("vs")
                    .foregroundStyle(.secondary)

                VStack {
                    Text("async/await")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    if let async = asyncDuration {
                        Text("\(String(format: "%.2f", async))s")
                            .font(.title2.bold())
                            .foregroundStyle(.green)
                    } else {
                        Text("-")
                            .font(.title2)
                            .foregroundStyle(.secondary)
                    }
                }
            }

            Text("두 방식 모두 병렬로 실행되어 비슷한 시간이 소요됩니다")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(.tertiarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    GCDDemoView()
}
