//
//  RCAppState.swift
//  ReactiveCounterApp
//
//  Created by 林 明虎 on 2025/02/17.
//

import Foundation
import ComposableArchitecture

enum RCAppStore {
    // State
    struct RCAppState: Equatable, Codable {
        var counters: IdentifiedArrayOf<RCounter> = []
        
        private static let userDefaultsKey = "RCAppState"
    }
    
    // 提供するStore
    static let store = Store(
        initialState: UserDefaultsManager.shared.load(forKey: .rcAppState) ?? RCAppState(),
        reducer: { CounterReducer() }
    )
}
