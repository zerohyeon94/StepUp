//
//  MiniProjectContainerView.swift
//  StepUp
//
//  Created by 조영현 on 3/4/26.
//

import SwiftUI

struct MiniProjectContainerView: View {
    let type: MiniProjectType

    var body: some View {
        MiniProjectViewControllerRepresentable(type: type)
            .navigationTitle(type.rawValue)
            .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - UIKit Bridge

struct MiniProjectViewControllerRepresentable: UIViewControllerRepresentable {
    let type: MiniProjectType

    func makeUIViewController(context: Context) -> UIViewController {
        MiniProjectFactory.makeViewController(for: type)
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // No updates needed
    }
}
