//
//  ARCDemoViewController.swift
//  StepUp
//
//  Created by 조영현 on 3/4/26.
//

import UIKit

final class ARCDemoViewController: UIViewController {

    // MARK: - Demo Objects

    private class DemoObject {
        let id: Int
        let onDeinit: (Int) -> Void

        init(id: Int, onDeinit: @escaping (Int) -> Void) {
            self.id = id
            self.onDeinit = onDeinit
            print("[ARC Demo] Object \(id) init")
        }

        deinit {
            onDeinit(id)
            print("[ARC Demo] Object \(id) deinit")
        }
    }

    // MARK: - Properties

    private var objects: [DemoObject] = []
    private var objectCounter = 0

    // MARK: - UI Components

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let contentStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "ARC 메모리 관리 데모"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "객체를 생성/해제하며 ARC의 메모리 관리를 확인하세요.\n각 객체는 참조 카운트가 0이 되면 deinit이 호출됩니다."
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private let countLabel: UILabel = {
        let label = UILabel()
        label.text = "활성 객체: 0"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center
        return label
    }()

    private lazy var createButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("객체 생성 (retain count +1)", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(createObject), for: .touchUpInside)
        return button
    }()

    private lazy var releaseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("마지막 객체 해제 (retain count -1)", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = .systemRed
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(releaseObject), for: .touchUpInside)
        return button
    }()

    private lazy var releaseAllButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("모든 객체 해제", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = .systemOrange
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(releaseAllObjects), for: .touchUpInside)
        return button
    }()

    private let objectsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 12
        return view
    }()

    private let objectsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .fillEqually
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let logTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.font = .monospacedSystemFont(ofSize: 11, weight: .regular)
        textView.backgroundColor = .secondarySystemBackground
        textView.layer.cornerRadius = 8
        return textView
    }()

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
        addLog("ARC Demo 초기화 완료")
    }

    // MARK: - Setup

    private func setupUI() {
        view.backgroundColor = .systemBackground

        view.addSubview(scrollView)
        scrollView.addSubview(contentStackView)

        // Add subviews to stack
        [titleLabel, descriptionLabel, countLabel].forEach {
            contentStackView.addArrangedSubview($0)
        }

        // Button stack
        let buttonStack = UIStackView(arrangedSubviews: [createButton, releaseButton])
        buttonStack.axis = .horizontal
        buttonStack.spacing = 8
        buttonStack.distribution = .fillEqually
        contentStackView.addArrangedSubview(buttonStack)
        contentStackView.addArrangedSubview(releaseAllButton)

        // Objects container
        objectsContainerView.addSubview(objectsStackView)
        contentStackView.addArrangedSubview(objectsContainerView)

        // Log view
        contentStackView.addArrangedSubview(logTextView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40),

            createButton.heightAnchor.constraint(equalToConstant: 44),
            releaseAllButton.heightAnchor.constraint(equalToConstant: 44),

            objectsContainerView.heightAnchor.constraint(equalToConstant: 80),
            objectsStackView.centerXAnchor.constraint(equalTo: objectsContainerView.centerXAnchor),
            objectsStackView.centerYAnchor.constraint(equalTo: objectsContainerView.centerYAnchor),
            objectsStackView.leadingAnchor.constraint(greaterThanOrEqualTo: objectsContainerView.leadingAnchor, constant: 8),
            objectsStackView.trailingAnchor.constraint(lessThanOrEqualTo: objectsContainerView.trailingAnchor, constant: -8),

            logTextView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

    // MARK: - Actions

    @objc private func createObject() {
        objectCounter += 1
        let newObject = DemoObject(id: objectCounter) { [weak self] id in
            self?.addLog("Object \(id) 메모리에서 해제됨 (deinit)")
            DispatchQueue.main.async {
                self?.updateObjectViews()
            }
        }
        objects.append(newObject)
        addLog("Object \(objectCounter) 생성됨 (retain count: 1)")
        updateObjectViews()
    }

    @objc private func releaseObject() {
        guard let removed = objects.popLast() else {
            addLog("해제할 객체가 없습니다")
            return
        }
        addLog("Object \(removed.id) 참조 해제 (retain count: 0 → deinit 예정)")
        updateObjectViews()
    }

    @objc private func releaseAllObjects() {
        let count = objects.count
        guard count > 0 else {
            addLog("해제할 객체가 없습니다")
            return
        }
        objects.removeAll()
        addLog("\(count)개 객체 모두 해제")
        updateObjectViews()
    }

    private func updateObjectViews() {
        objectsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        for object in objects.prefix(8) {
            let objectView = createObjectView(id: object.id)
            objectsStackView.addArrangedSubview(objectView)
        }

        if objects.count > 8 {
            let moreLabel = UILabel()
            moreLabel.text = "+\(objects.count - 8)"
            moreLabel.font = .systemFont(ofSize: 12, weight: .medium)
            moreLabel.textColor = .secondaryLabel
            objectsStackView.addArrangedSubview(moreLabel)
        }

        countLabel.text = "활성 객체: \(objects.count)"
    }

    private func createObjectView(id: Int) -> UIView {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false

        let label = UILabel()
        label.text = "\(id)"
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(label)

        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: 40),
            view.heightAnchor.constraint(equalToConstant: 40),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        return view
    }

    private func addLog(_ message: String) {
        let timestamp = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .medium)
        logs.append("[\(timestamp)] \(message)")
        logTextView.text = logs.joined(separator: "\n")

        if !logTextView.text.isEmpty {
            let bottom = NSRange(location: logTextView.text.count - 1, length: 1)
            logTextView.scrollRangeToVisible(bottom)
        }
    }
}
