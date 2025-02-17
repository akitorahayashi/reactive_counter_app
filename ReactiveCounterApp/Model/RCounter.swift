//
//  RCounter.swift
//  ReactiveCounterApp
//
//  Created by 林 明虎 on 2025/02/17.
//

import Foundation

struct RCounter: Identifiable, Codable, Equatable {
    let id: UUID
    var count: Int
    var title: String?
    var memo: String?
    
    init(id: UUID, count: Int, title: String? = nil, memo: String? = nil) {
        self.id = id
        self.count = count
        self.title = title
        self.memo = memo
    }
}
