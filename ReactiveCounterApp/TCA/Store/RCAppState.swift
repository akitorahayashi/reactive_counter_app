//
//  RCAppState.swift
//  ReactiveCounterApp
//
//  Created by 林 明虎 on 2025/02/17.
//

import ComposableArchitecture
import Foundation

enum RCAppStore {
    // State
    struct RCAppState: Equatable, Codable {
        var counters: IdentifiedArrayOf<RCounter> = []
        
        private static let userDefaultsKey = "RCAppState"

        // UserDefaults から状態を読み込む
        static func load() -> RCAppState {
            guard let data = UserDefaults.standard.data(forKey: userDefaultsKey) else {
                return RCAppState()
            }
            let decoder = JSONDecoder()
            return (try? decoder.decode(RCAppState.self, from: data)) ?? RCAppState()
        }

        // UserDefaults に保存する
        func save() {
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(self) {
                UserDefaults.standard.set(data, forKey: RCAppState.userDefaultsKey)
            }
        }
    }
    
    // UserDefaults から読み込んだ初期状態を使用
    static let store = Store(initialState: RCAppState.load(), reducer: { CounterReducer() })
}
