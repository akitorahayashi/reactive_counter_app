//
//  SingleCounterWidgetEntryView.swift
//  ReactiveCounterApp
//
//  Created by 林 明虎 on 2025/02/17.
//

import SwiftUI

struct SingleCounterWidgetEntryView : View {
    var entry: SCProvider.Entry

    var body: some View {
        VStack {
            Text("Time:")
            Text(entry.date, style: .time)

            Text("Favorite Emoji:")
            Text(entry.configuration.favoriteEmoji)
        }
    }
}
