//
//  CounterGridView.swift
//  ReactiveCounterApp
//
//  Created by 林 明虎 on 2025/02/17.
//

import SwiftUI
import ComposableArchitecture

/// GridレイアウトでRCounterを一覧表示する画面
struct CounterGridView: View {
    
    let store: StoreOf<CounterReducer>
    
    @State private var showingAddCounterSheet = false
    @State private var newCounterValue = ""
    
    private let buttonSizeOfFAB: CGFloat = 60
    
    var body: some View {
        NavigationView {
            WithViewStore(store, observe: { $0 }) { viewStore in
                ZStack {
                    ScrollView {
                        LazyVGrid(
                            columns: [
                                GridItem(.flexible(), spacing: 10),
                                GridItem(.flexible())
                            ],
                            spacing: 10
                        ) {
                            ForEach(viewStore.counters) { counter in
                                // セルをタップで詳細画面へ
                                NavigationLink(destination: CounterDetailView(store: store, counter: counter)) {
                                    counterGridCell(counter)
                                }
                            }
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 10)
                    }
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            addCounterFAB(viewStore)
                                .padding()
                        }
                    }
                }
                .navigationTitle("Counter Grid")
                .sheet(isPresented: $showingAddCounterSheet) {
                    addCounterSheet(viewStore)
                }
            }
        }
    }
    
    private func counterGridCell(_ counter: RCounter) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray, lineWidth: 1)
            Text("\(counter.count)")
                .font(.system(size: 16))
                .padding()
        }
        .frame(height: 120)
    }
    
    private func addCounterFAB(_ viewStore: ViewStore<RCAppStore.RCAppState, CounterAction>) -> some View {
        Button {
            showingAddCounterSheet = true
        } label: {
            Text("+")
                .font(.system(size: 24, weight: .medium))
                .foregroundColor(.accentColor)
                .frame(width: buttonSizeOfFAB, height: buttonSizeOfFAB)
                .background(Color.white)
                .cornerRadius(buttonSizeOfFAB / 2)
                .shadow(radius: 3)
        }
    }
    
    private func addCounterSheet(_ viewStore: ViewStore<RCAppStore.RCAppState, CounterAction>) -> some View {
        NavigationView {
            Form {
                Section(header: Text("新しい Counter の初期値")) {
                    TextField("0", text: $newCounterValue)
                        .keyboardType(.numberPad)
                }
            }
            .navigationBarItems(
                leading: Button("Cancel") {
                    showingAddCounterSheet = false
                },
                trailing: Button("OK") {
                    if let intValue = Int(newCounterValue) {
                        viewStore.send(.addCounter(UUID(), intValue))
                    }
                    newCounterValue = ""
                    showingAddCounterSheet = false
                }
            )
            .navigationTitle("Add Counter")
        }
    }
}
