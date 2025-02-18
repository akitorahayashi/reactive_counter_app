//
//  SingleCounterWidgetEntryView.swift
//  ReactiveCounterApp
//
//  Created by 林 明虎 on 2025/02/17.
//

import AppIntents
import SwiftUI

struct SingleCounterWidgetView: View {
    var entry: SCEntry

    var body: some View {
        if let selectedCounter = entry.entity {
            HStack {
                // マイナスボタン
                // Cannot convert value of type 'CounterSelectionAppEntity' to expected argument type 'LocalizedStringResource'
                Button(intent: DecrementCounterIntent()) {
                    Image(systemName: "minus.circle.fill")
                        .font(.title2)
                }

                // 現在のカウント表示
                Text("\(selectedCounter.count)")
                    .font(.title2)
                    .bold()

                // プラスボタン
                Button(intent: IncrementCounterIntent()) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title2)
                }
            }
        } else {
            // 未選択時の案内メッセージ
            VStack {
                Text("カウンターが選択されていません")
                    .font(.headline)
                    .bold()
                    .padding(.bottom, 4)

                Text("アプリ内でカウンターを追加し、")
                    .font(.caption)
                Text("このウィジェットを長押しして編集すると、")
                    .font(.caption)
                Text("表示するカウンターを選べます。")
                    .font(.caption)
            }
            .multilineTextAlignment(.center)
            .padding()
        }
    }
}
