//
//  CounterReducerTests.swift
//  ReactiveCounterAppTests
//
//  Created by 林 明虎 on 2025/02/18.
//

import XCTest
import ComposableArchitecture
@testable import ReactiveCounterApp

final class CounterReducerTests: XCTestCase {
    
    func testAddCounter() async {
        let store = await TestStore(
            initialState: RCAppStore.RCAppState(),
            reducer: { CounterReducer() }
        )
        
        let counterID = UUID()
        await store.send(.addCounter(counterID, 5)) {
            $0.counters.append(RCounter(id: counterID, count: 5))
        }
    }

    
    func testDeleteCounter() async {
        let counterID = UUID()
        let store = await TestStore(
            initialState: RCAppStore.RCAppState(
                counters: [RCounter(id: counterID, count: 10)]
            ),
            reducer: { CounterReducer() }
        )
        
        await store.send(.deleteCounter(counterID)) {
            $0.counters.remove(id: counterID)
        }
    }
    
    func testIncreaseCount() async {
        let counterID = UUID()
        let store = await TestStore(
            initialState: RCAppStore.RCAppState(
                counters: [RCounter(id: counterID, count: 10)]
            ),
            reducer: { CounterReducer() }
        )
        
        await store.send(.increaseCount(counterID)) {
            $0.counters[id: counterID]?.count += 1
        }
    }
    
    func testDecreaseCount() async {
        let counterID = UUID()
        let store = await TestStore(
            initialState: RCAppStore.RCAppState(
                counters: [RCounter(id: counterID, count: 10)]
            ),
            reducer: { CounterReducer() }
        )
        
        await store.send(.decreaseCount(counterID)) {
            $0.counters[id: counterID]?.count -= 1
        }
    }
    
    func testUpdateTitle() async {
        let counterID = UUID()
        let store = await TestStore(
            initialState: RCAppStore.RCAppState(
                counters: [RCounter(id: counterID, count: 10, title: "Old Title")]
            ),
            reducer: { CounterReducer() }
        )
        
        await store.send(.updateTitle(counterID, "New Title")) {
            $0.counters[id: counterID]?.title = "New Title"
        }
    }
    
    func testUpdateMemo() async {
        let counterID = UUID()
        let store = await TestStore(
            initialState: RCAppStore.RCAppState(
                counters: [RCounter(id: counterID, count: 10, memo: "Old Memo")]
            ),
            reducer: { CounterReducer() }
        )
        
        await store.send(.updateMemo(counterID, "New Memo")) {
            $0.counters[id: counterID]?.memo = "New Memo"
        }
    }
}
