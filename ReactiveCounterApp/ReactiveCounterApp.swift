//
//  ReactiveCounterApp.swift
//  ReactiveCounterApp
//
//  Created by 林 明虎 on 2025/02/17.
//

import SwiftUI
import ComposableArchitecture

@main
struct ReactiveCounterApp: App {
    var body: some Scene {
        WindowGroup {
            CounterGridView(store: RCAppStore.store)
        }
    }
}
