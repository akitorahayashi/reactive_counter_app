//
//  SingleCounterWidgetEntryView.swift
//  ReactiveCounterApp
//
//  Created by 林 明虎 on 2025/02/17.
//

import SwiftUI

struct SingleCounterWidgetView: View {
    var entry: SCEntry

    var body: some View {
        HStack {
            // マイナスボタン
            Button(intent: DecrementCounterIntent()) {
                Image(systemName: "minus.circle.fill")
                    .font(.title2)
            }

            // 現在のカウント表示
            Text("\(entry.count)")
                .font(.title2)
                .bold()

            // プラスボタン
            Button(intent: IncrementCounterIntent()) {
                Image(systemName: "plus.circle.fill")
                    .font(.title2)
            }
        }
    }
}

