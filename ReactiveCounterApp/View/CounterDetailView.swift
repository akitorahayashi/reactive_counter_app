//
//  CounterDetailView.swift
//  ReactiveCounterApp
//
//  Created by 林 明虎 on 2025/02/17.
//

import SwiftUI
import ComposableArchitecture

/// 選択したカウンターの詳細画面
struct CounterDetailView: View {
    let store: StoreOf<CounterReducer>
    let counter: RCounter

    /// タイトルとメモをView内部で編集するためのState
    @State private var title: String
    @State private var memo: String

    init(store: StoreOf<CounterReducer>, counter: RCounter) {
        self.store = store
        self.counter = counter
        _title = State(initialValue: counter.title ?? "")
        _memo = State(initialValue: counter.memo ?? "")
    }

    var body: some View {
        VStack {
            counterValueSection
            Divider()
            titleAndMemoSection
            Spacer()
        }
        .navigationTitle("Counter Detail")
        // 画面から離れるときにViewStoreへ送信して更新
        .onDisappear {
            let viewStore = ViewStore(store, observe: { $0 })
            viewStore.send(.updateTitle(counter.id, title))
            viewStore.send(.updateMemo(counter.id, memo))
        }
    }

    // MARK: - カウンター値 + インクリメント/デクリメント
    private var counterValueSection: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                HStack(spacing: 50) {
                    Button {
                        ViewStore(store, observe: { $0 }).send(.decreaseCount(counter.id))
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.accentColor)
                            .frame(width: 60, height: 60)
                    }

                    Text("\(counter.count)")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.gray)
                        .frame(height: 40)

                    Button {
                        ViewStore(store, observe: { $0 }).send(.increaseCount(counter.id))
                    } label: {
                        Image(systemName: "chevron.right")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.accentColor)
                            .frame(width: 60, height: 60)
                    }
                }
                Spacer()
            }
            .frame(width: geometry.size.width, height: geometry.size.width)
        }
        .frame(height: UIScreen.main.bounds.width)
    }

    // MARK: - タイトル & メモ入力フォーム
    private var titleAndMemoSection: some View {
        Form {
            Section(header: Text("Title").foregroundColor(.gray)) {
                TextField("タイトルを入力", text: $title)
            }
            Section(header: Text("Memo").foregroundColor(.gray)) {
                TextEditor(text: $memo)
                    .frame(minHeight: 80)
            }
        }
    }
}
