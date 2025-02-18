//
//  CounterSelectionAppEntity.swift
//  ReactiveCounterApp
//
//  Created by 林 明虎 on 2025/02/18.
//

import AppIntents
import Foundation

// カウンターを取得するためのクエリ
struct CounterQuery: EntityQuery {
    func entities(for identifiers: [CounterSelectionAppEntity.ID]) -> [CounterSelectionAppEntity] {
        let allEntities = self.loadCounters()
        return allEntities.filter { identifiers.contains($0.id) }
    }
    
    func suggestedEntities() -> [CounterSelectionAppEntity] {
        return self.loadCounters()
    }
    
    // すべてのカウンターを取得
    func loadCounters() -> [CounterSelectionAppEntity] {
        guard let appState: RCAppStore.RCAppState = UserDefaultsManager.shared.load(forKey: .rcAppStateKey) else {
            return []
        }
        
        return appState.counters.enumerated().map { index, counter in
            CounterSelectionAppEntity(
                id: counter.id.uuidString,
                counterID: counter.id,
                // ユーザーにとって直感的なindexの番号を提供
                index: index + 1,
                customTitle: counter.title,
                count: counter.count // 追加
            )
        }
    }
}

// ユーザーが選択できるカウンターのエンティティ
struct CounterSelectionAppEntity: AppEntity, Identifiable {
    static var defaultQuery = CounterQuery()
    
    static var typeDisplayRepresentation = TypeDisplayRepresentation(name: "Counter")
    
    let id: String  // これ自体の識別子
    let counterID: UUID  // RCounter の UUID
    let index: Int  // 表示用のインデックス
    let customTitle: String?  // ユーザーがCounterに対して設定したタイトル
    let count: Int // カウンターの値
    
    // snapshotなどに使用
    static var defaultEntity: CounterSelectionAppEntity {
        return CounterSelectionAppEntity(
            id: "default",
            counterID: UUID(),
            index: 0,
            customTitle: "Default Counter",
            count: 3
        )
    }
    
    // ユーザーに表示するカウンター名
    var displayRepresentation: DisplayRepresentation {
        let baseTitle = "Counter \(index)"
        
//        let finalTitle = customTitle.map { "\(baseTitle) - \($0)" } ?? baseTitle
        
        if let title = customTitle {
            return DisplayRepresentation(title: LocalizedStringResource(stringLiteral: "\(baseTitle) - \(title)"))
        } else {
            return DisplayRepresentation(title: LocalizedStringResource(stringLiteral: baseTitle))
        }
    }

}
