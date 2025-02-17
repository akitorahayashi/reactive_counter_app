//
//  CounterReducer.swift
//  ReactiveCounterApp
//
//  Created by 林 明虎 on 2025/02/17.
//

import Foundation
import ComposableArchitecture

struct CounterReducer: Reducer {
    typealias State = RCAppStore.RCAppState
    typealias Action = CounterAction
    
    func reduce(into state: inout RCAppStore.RCAppState, action: CounterAction) -> Effect<CounterAction> {
        switch action {
            
        case let .addCounter(initialValue):
            self.addCounter(to: &state, initialValue: initialValue)
            
        case let .deleteCounter(counterID):
            self.deleteCounter(in: &state, counterID: counterID)
            
        case let .increaseCount(counterID):
            self.increaseCount(in: &state, counterID: counterID)
            
        case let .decreaseCount(counterID):
            self.decreaseCount(in: &state, counterID: counterID)
            
        case let .updateTitle(counterID, newTitle):
            self.updateCounterTitle(in: &state, counterID: counterID, newTitle: newTitle)
            
        case let .updateMemo(counterID, newMemo):
            self.updateCounterMemo(in: &state, counterID: counterID, newMemo: newMemo)
        }
        
        try? UserDefaultsManager.shared.save(state, forKey: .rcAppState)
        return .none
    }
    
    private func addCounter(to state: inout RCAppStore.RCAppState, initialValue: Int) {
        state.counters.append(RCounter(count: initialValue))
    }
    
    private func deleteCounter(in state: inout RCAppStore.RCAppState, counterID: UUID) {
        state.counters.remove(id: counterID)
    }
    
    private func increaseCount(in state: inout RCAppStore.RCAppState, counterID: UUID) {
        state.counters[id: counterID]?.count += 1
    }
    
    private func decreaseCount(in state: inout RCAppStore.RCAppState, counterID: UUID) {
        state.counters[id: counterID]?.count -= 1
    }
    
    private func updateCounterTitle(in state: inout RCAppStore.RCAppState, counterID: UUID, newTitle: String?) {
        state.counters[id: counterID]?.title = newTitle
    }
    
    private func updateCounterMemo(in state: inout RCAppStore.RCAppState, counterID: UUID, newMemo: String?) {
        state.counters[id: counterID]?.memo = newMemo
    }
}
