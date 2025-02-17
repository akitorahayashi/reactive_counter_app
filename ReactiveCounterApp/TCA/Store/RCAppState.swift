//
//  RCAppState.swift
//  ReactiveCounterApp
//
//  Created by 林 明虎 on 2025/02/17.
//

import ComposableArchitecture

enum RCAppStore {
    // State
    struct RCAppState: Equatable {
        var counters: IdentifiedArrayOf<RCounter> = [RCounter(count: 0), RCounter(count: 1), RCounter(count: 0), RCounter(count: 0)]
    }
    
    // 単一のStoreを提供
    static let store = Store(initialState: RCAppState(), reducer: { CounterReducer() })
}
