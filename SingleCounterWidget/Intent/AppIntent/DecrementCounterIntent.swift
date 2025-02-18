//
//  DecrementCounterIntent.swift
//  ReactiveCounterApp
//
//  Created by 林 明虎 on 2025/02/18.
//

import WidgetKit
import AppIntents

/// カウントを -1 する Intent
struct DecrementCounterIntent: AppIntent {
    static var title: LocalizedStringResource = "Decrement Counter"

    func perform() async throws -> some IntentResult {
        // 「現在ウィジェットで選択されているカウンター」を Provider の timeline で UserDefaults に記録してある
        guard let selectedUUIDString = UserDefaults.standard.string(forKey: "selectedCounterUUID"),
              let selectedUUID = UUID(uuidString: selectedUUIDString),
              var appState: RCAppStore.RCAppState = UserDefaultsManager.shared.load(forKey: .rcAppStateKey),
              let index = appState.counters.firstIndex(where: { $0.id == selectedUUID })
        else {
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
