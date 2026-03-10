//
//  MiniProjectFactory.swift
//  StepUp
//
//  Created by 조영현 on 3/4/26.
//

import UIKit
import SwiftUI

enum MiniProjectFactory {
    @MainActor
    static func makeViewController(for type: MiniProjectType) -> UIViewController {
        switch type {
        case .appLifecycle:
            return AppLifecycleDemoViewController()
        case .arc:
            return ARCDemoViewController()
        case .gcd:
            return UIHostingController(rootView: GCDDemoView())
        case .runloop:
            return UIHostingController(rootView: RunLoopDemoView())
        }
    }
}
