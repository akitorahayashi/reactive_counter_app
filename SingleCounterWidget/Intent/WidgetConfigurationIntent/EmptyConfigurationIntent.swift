//
//  EmptyConfigurationIntent.swift
//  ReactiveCounterApp
//
//  Created by 林 明虎 on 2025/02/18.
//

import AppIntents

struct CounterSelectionIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Counter Widget"
    static var description = IntentDescription("A single counter widget.")
    
    @Parameter(title: "Select Counter", default: nil)
    var selectedCounter: CounterSelectionAppEntity?
    
    static var parameterSummary: some ParameterSummary {
        Summary("Select Counter: \(\.$selectedCounter)")
    }
}
