//
//  EmptyConfigurationIntent.swift
//  ReactiveCounterApp
//
//  Created by 林 明虎 on 2025/02/18.
//

import AppIntents

struct EmptyConfigurationIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Counter Widget"
    static var description = IntentDescription("A single counter widget.")
}
