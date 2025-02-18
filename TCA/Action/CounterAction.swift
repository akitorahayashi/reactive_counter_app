//
//  CounterAction.swift
//  ReactiveCounterApp
//
//  Created by 林 明虎 on 2025/02/17.
//

import Foundation

enum CounterAction {
    case addCounter(UUID, Int)
    case deleteCounter(UUID)
    case increaseCount(UUID)
    case decreaseCount(UUID)
    case updateTitle(UUID, String?)
    case updateMemo(UUID, String?)
}
