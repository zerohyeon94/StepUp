//
//  CardRoute.swift
//  StepUp
//
//  Created by 조영현 on 3/4/26.
//

import Foundation

enum CardRoute: Hashable {
    case list
    case detail(InterviewCard)
    case miniProject(MiniProjectType)
}
