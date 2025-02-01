//
//  Counter.swift
//  reactive_counter_app
//
//  Created by 林 明虎 on 2025/01/12.
//

import Foundation

struct RCCounter: Identifiable, Codable {
    let id: UUID
    var value: Int
    var title: String?
    var memo: String?
    
    init(value: Int = 0) {
        self.id = UUID()
        self.value = value
    }
}
