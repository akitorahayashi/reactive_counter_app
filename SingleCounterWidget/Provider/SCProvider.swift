//
//  SCProvider.swift
//  ReactiveCounterApp
//
//  Created by 林 明虎 on 2025/02/17.
//

import WidgetKit

import WidgetKit

struct SCProvider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SCEntry {
        SCEntry(date: Date(), entity: nil)
    }
    
    func snapshot(for configuration: CounterSelectionIntent, in context: Context) async -> SCEntry {
        let entity = CounterSelectionAppEntity.defaultEntity
        return SCEntry(date: Date(), entity: entity)
    }
    
    func timeline(for configuration: CounterSelectionIntent, in context: Context) async -> Timeline<SCEntry> {
        // ウィジェットで選択されたエンティティ
        guard let selectedEntity = configuration.selectedCounter else {
            return Timeline(entries: [SCEntry(date: Date(), entity: nil)], policy: .never)
        }
        
        // その ID をグローバルに保存 (Intent用に再利用)
        UserDefaults.standard.set(selectedEntity.counterID.uuidString, forKey: "selectedCounterUUID")
        
        // UserDefaults から最新の appState を取得
        guard let appState: RCAppStore.RCAppState = UserDefaultsManager.shared.load(forKey: .rcAppStateKey) else {
            // 何もない場合は nil で返す
            return Timeline(entries: [SCEntry(date: Date(), entity: nil)], policy: .never)
        }
        
        // 最新のカウンター情報を検索
        if let updatedRCounter = appState.counters.first(where: { $0.id == selectedEntity.counterID }) {
            
            // 既存の selectedEntity を元に、新しい count を持つエンティティを組み立てる
            let updatedEntity = CounterSelectionAppEntity(
                id: selectedEntity.id,
                counterID: selectedEntity.counterID,
                index: selectedEntity.index,
                customTitle: selectedEntity.customTitle,
                count: updatedRCounter.count
            )
            
            // 新しいエントリを返す
            let entry = SCEntry(date: Date(), entity: updatedEntity)
            return Timeline(entries: [entry], policy: .never)
        } else {
            // 万が一見つからなかったら、デフォルトのエントリを返す
            let entry = SCEntry(date: Date(), entity: nil)
            return Timeline(entries: [entry], policy: .never)
        }
    }
}
