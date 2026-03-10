//
//  AppLifecycleDemoViewController.swift
//  StepUp
//
//  Created by 조영현 on 3/4/26.
//

import UIKit
import Combine

final class AppLifecycleDemoViewController: UIViewController {

    // MARK: - UI Components

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "App 생명주기 데모"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let stateLabel: UILabel = {
        let label = UILabel()
        label.text = "현재 상태: Active"
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let stateIndicator: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen
        view.layer.cornerRadius = 50
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "앱을 백그라운드로 보내거나 다시 포그라운드로 가져와 상태 변화를 확인하세요"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let logTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.font = .monospacedSystemFont(ofSize: 12, weight: .regular)
        textView.backgroundColor = .secondarySystemBackground
        textView.layer.cornerRadius = 8
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    private var cancellables = Set<AnyCancellable>()
    private var logs: [String] = []

    // MARK: - Lifecycle

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Storyboard not supported")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNotifications()
        addLog("viewDidLoad 호출됨")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addLog("viewWillAppear 호출됨")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addLog("viewDidAppear 호출됨")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        addLog("viewWillDisappear 호출됨")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        addLog("viewDidDisappear 호출됨")
    }

    deinit {
        print("[AppLifecycleDemo] deinit 호출됨")
    }

    // MARK: - Setup

    private func setupUI() {
        view.backgroundColor = .systemBackground

        view.addSubview(titleLabel)
        view.addSubview(stateIndicator)
        view.addSubview(stateLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(logTextView)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            stateIndicator.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            stateIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stateIndicator.widthAnchor.constraint(equalToConstant: 100),
            stateIndicator.heightAnchor.constraint(equalToConstant: 100),

            stateLabel.topAnchor.constraint(equalTo: stateIndicator.bottomAnchor, constant: 16),
            stateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            descriptionLabel.topAnchor.constraint(equalTo: stateLabel.bottomAnchor, constant: 12),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            logTextView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 24),
            logTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            logTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            logTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }

    private func setupNotifications() {
        NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)
            .sink { [weak self] _ in
                self?.updateState(.active)
            }
            .store(in: &cancellables)

        NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)
            .sink { [weak self] _ in
                self?.updateState(.inactive)
            }
            .store(in: &cancellables)

        NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)
            .sink { [weak self] _ in
                self?.updateState(.background)
            }
            .store(in: &cancellables)

        NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)
            .sink { [weak self] _ in
                self?.updateState(.foreground)
            }
            .store(in: &cancellables)
    }

    // MARK: - State Management

    private enum AppState {
        case active, inactive, background, foreground

        var displayName: String {
            switch self {
            case .active: return "Active"
            case .inactive: return "Inactive"
            case .background: return "Background"
            case .foreground: return "Foreground"
            }
        }

        var color: UIColor {
            switch self {
            case .active: return .systemGreen
            case .inactive: return .systemYellow
            case .background: return .systemRed
            case .foreground: return .systemBlue
            }
        }

        var description: String {
            switch self {
            case .active: return "앱이 화면에 표시되고 이벤트를 받고 있습니다"
            case .inactive: return "앱이 화면에 있지만 이벤트를 받지 않습니다"
            case .background: return "앱이 백그라운드에서 실행 중입니다"
            case .foreground: return "앱이 포그라운드로 전환 중입니다"
            }
        }
    }

    private func updateState(_ state: AppState) {
        addLog("상태 변경: \(state.displayName) - \(state.description)")

        UIView.animate(withDuration: 0.3) {
            self.stateIndicator.backgroundColor = state.color
            self.stateLabel.text = "현재 상태: \(state.displayName)"
        }
    }

    private func addLog(_ message: String) {
        let timestamp = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .medium)
        logs.append("[\(timestamp)] \(message)")
        logTextView.text = logs.joined(separator: "\n")

        // Scroll to bottom
        if !logTextView.text.isEmpty {
            let bottom = NSRange(location: logTextView.text.count - 1, length: 1)
            logTextView.scrollRangeToVisible(bottom)
        }
    }
}
