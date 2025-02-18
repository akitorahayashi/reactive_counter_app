//
//  SingleCounterWidget.swift
//  SingleCounterWidget
//
//  Created by 林 明虎 on 2025/02/17.
//

import WidgetKit
import SwiftUI

struct SingleCounterWidget: Widget {
    static let kind: String = "SingleCounterWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: SingleCounterWidget.kind, intent: CounterSelectionIntent.self, provider: SCProvider()) { entry in
            SingleCounterWidgetView(entry: entry)
        }
        .configurationDisplayName("Single Counter")
        .description("A widget with a single counter, plus and minus buttons.")
        .supportedFamilies([.systemMedium])
    }
}
