//
//  SingleCounterWidget.swift
//  SingleCounterWidget
//
//  Created by 林 明虎 on 2025/02/17.
//

import WidgetKit
import SwiftUI

struct SingleCounterWidget: Widget {
    let kind: String = "SingleCounterWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: SCProvider()) { entry in
            SingleCounterWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}

#Preview(as: .systemSmall) {
    SingleCounterWidget()
} timeline: {
    SCEntry(date: .now, configuration: .smiley)
    SCEntry(date: .now, configuration: .starEyes)
}
