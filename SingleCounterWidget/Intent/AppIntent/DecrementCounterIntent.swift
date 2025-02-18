//
//  DecrementCounterIntent.swift
//  ReactiveCounterApp
//
//  Created by 林 明虎 on 2025/02/18.
//

import AppIntents
import WidgetKit

/// カウントを -1 する Intent
struct DecrementCounterIntent: AppIntent {
    static var title: LocalizedStringResource = "Decrement Counter"

    func perform() async throws -> some IntentResult {
        guard var appState: RCAppStore.RCAppState = UserDefaultsManager.shared.load(forKey: .rcAppStateKey),
              let firstCounterID = appState.counters.first?.id,
              let index = appState.counters.index(id: firstCounterID) else {
            return .result()
        }

        // カウントを -1
        appState.counters[index].count -= 1
        try UserDefaultsManager.shared.save(appState, forKey: .rcAppStateKey)

        // ウィジェットの再描画
        WidgetCenter.shared.reloadTimelines(ofKind: "SingleCounterWidget")

        return .result()
    }
}
