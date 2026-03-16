//
//  SeedCardExclusion.swift
//  StepUp
//
//  Created by Claude on 3/15/26.
//

import Foundation

/// 사용자가 영구 삭제한 시드 카드의 stableId를 기록하여
/// 앱 재실행 시 syncSeedData에서 다시 생성되지 않도록 방지합니다.
enum SeedCardExclusion {
    private static let key = "excludedSeedCardIds"

    static func excludedIds() -> Set<String> {
        let array = UserDefaults.standard.stringArray(forKey: key) ?? []
        return Set(array)
    }

    static func addExcludedId(_ stableId: String) {
        var ids = excludedIds()
        ids.insert(stableId)
        UserDefaults.standard.set(Array(ids), forKey: key)
    }

    static func removeExcludedId(_ stableId: String) {
        var ids = excludedIds()
        ids.remove(stableId)
        UserDefaults.standard.set(Array(ids), forKey: key)
    }
}
