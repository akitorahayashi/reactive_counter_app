//
//  SCProvider.swift
//  ReactiveCounterApp
//
//  Created by 林 明虎 on 2025/02/17.
//

import WidgetKit

struct SimpleProvider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SCEntry {
        SCEntry(date: Date(), count: 0)
    }
    
    func snapshot(for configuration: EmptyConfigurationIntent, in context: Context) async -> SCEntry {
        return SCEntry(date: Date(), count: 3)
    }
    
    func timeline(for configuration: EmptyConfigurationIntent, in context: Context) async -> Timeline<SCEntry> {
        let appState: RCAppStore.RCAppState? = UserDefaultsManager.shared.load(forKey: .rcAppStateKey)
        let count = appState?.counters.first?.count ?? 0

        let entry = SCEntry(date: Date(), count: count)
        
        return Timeline(entries: [entry], policy: .never)
    }
}
