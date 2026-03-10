//
//  Coordinator.swift
//  StepUp
//
//  Created by 조영현 on 3/4/26.
//

import SwiftUI

protocol Coordinator: AnyObject {
    associatedtype Route: Hashable
    var childCoordinators: [any Coordinator] { get set }
    func start() -> AnyView
}

extension Coordinator {
    func addChild(_ coordinator: any Coordinator) {
        childCoordinators.append(coordinator)
    }

    func removeChild(_ coordinator: any Coordinator) {
        childCoordinators.removeAll { $0 === coordinator }
    }
}
