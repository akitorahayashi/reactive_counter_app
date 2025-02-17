//
//  UserDefaultsManager.swift
//  ReactiveCounterApp
//
//  Created by 林 明虎 on 2025/02/18.
//

import Foundation

final class UserDefaultsManager {
    static let shared = UserDefaultsManager(suiteName: "group.akitorahayashi.reactiveCounterApp")
    
    private let userDefaults: UserDefaults
    
    private init(suiteName: String) {
        self.userDefaults = UserDefaults(suiteName: suiteName) ?? .standard
    }
    
    // MARK: - Keys
    enum UserDefaultsKeys: String {
        case rcAppState
    }
    
    // MARK: - Operation
    func save<T: Codable>(_ item: T, forKey key: UserDefaultsKeys) throws {
        do {
            let data = try JSONEncoder().encode(item)
            userDefaults.set(data, forKey: key.rawValue)
        } catch {
            throw error
        }
    }
    
    func load<T: Codable>(forKey key: UserDefaultsKeys) -> T? {
        guard let data = userDefaults.data(forKey: key.rawValue) else {
            return nil
        }
        return try? JSONDecoder().decode(T.self, from: data)
    }
    
    func remove(forKey key: UserDefaultsKeys) {
        userDefaults.removeObject(forKey: key.rawValue)
    }
    
    func exists(forKey key: UserDefaultsKeys) -> Bool {
        return userDefaults.object(forKey: key.rawValue) != nil
    }
}
