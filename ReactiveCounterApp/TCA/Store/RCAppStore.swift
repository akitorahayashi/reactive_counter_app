//
//  RCAppStore.swift
//  ReactiveCounterApp
//
//  Created by 林 明虎 on 2025/02/18.
//

import Foundation
import ComposableArchitecture

enum RCAppStore {
    // State
    struct RCAppState: Equatable, Codable {
        var counters: IdentifiedArrayOf<RCounter> = []
    }
    
    static let store = Store(
        initialState: UserDefaultsManager.shared.load(forKey: .rcAppState) ?? RCAppState(),
        reducer: { CounterReducer() }
    )
}

