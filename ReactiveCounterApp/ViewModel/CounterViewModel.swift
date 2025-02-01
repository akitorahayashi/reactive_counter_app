//
//  CounterViewModel.swift
//  ReactiveCounterApp
//
//  Created by 林 明虎 on 2025/02/02.
//

import Foundation
import Combine

class CounterViewModel: ObservableObject {
    @Published var counters: [RCCounter] = []
    private let userDefaultsKey = "countersKey"
    
    init() {
        loadCountersFromUserDefaults()
    }
    
    func addCounter(initialValue: Int) {
        let newCounter = RCCounter(value: initialValue)
        counters.append(newCounter)
        saveCountersToUserDefaults()
    }
    
    func deleteCounter(at index: Int) {
        counters.remove(at: index)
        saveCountersToUserDefaults()
    }
    
    func incrementCounter(at index: Int) {
        guard counters.indices.contains(index) else { return }
        counters[index].value += 1
        saveCountersToUserDefaults()
    }
    
    func decrementCounter(at index: Int) {
        guard counters.indices.contains(index) else { return }
        counters[index].value -= 1
        saveCountersToUserDefaults()
    }
    
    private func saveCountersToUserDefaults() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(counters) {
            UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
        }
    }
    
    private func loadCountersFromUserDefaults() {
        let decoder = JSONDecoder()
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decodedCounters = try? decoder.decode([RCCounter].self, from: savedData) {
            counters = decodedCounters
        } else {
            counters = [RCCounter(value: 0)]
        }
    }
}
