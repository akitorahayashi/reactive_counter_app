//
//  SingleCounterWidget.swift
//  SingleCounterWidget
//
//  Created by 林 明虎 on 2025/02/17.
//

import WidgetKit
import SwiftUI

// ウィジェットの定義
struct SingleCounterWidget: Widget {
    let kind: String = "SingleCounterWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: EmptyConfigurationIntent.self, provider: SimpleProvider()) { entry in
            SingleCounterWidgetView(entry: entry)
        }
        .configurationDisplayName("Single Counter")
        .description("A widget with a single counter, plus and minus buttons.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}
