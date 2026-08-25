//
//  GenericCache.swift
//  GenericAssignment
//
//  Created by Mangesh Shiudkar on 25/08/26.
//

import Foundation

class Cache<Key: Hashable, Value> {

    private let capacity: Int
    private var storage: [Key: Value] = [:]
    private var usageOrder: [Key] = []

    init(capacity: Int) {
        self.capacity = capacity
    }

    func set(_ value: Value, forKey key: Key) {
        if storage[key] != nil {
            storage[key] = value
            updateUsage(for: key)
            return
        }
        if storage.count >= capacity,
           let leastRecentlyUsedKey = usageOrder.first {
            storage.removeValue(forKey: leastRecentlyUsedKey)
            usageOrder.removeFirst()
        }
        storage[key] = value
        usageOrder.append(key)
    }

    func get(_ key: Key) -> Value? {
        guard let value = storage[key] else {
            return nil
        }
        updateUsage(for: key)
        return value
    }

    func remove(_ key: Key) {
        storage.removeValue(forKey: key)
        if let index = usageOrder.firstIndex(of: key) {
            usageOrder.remove(at: index)
        }
    }

    private func updateUsage(for key: Key) {
        if let index = usageOrder.firstIndex(of: key) {
            usageOrder.remove(at: index)
        }
        usageOrder.append(key)
    }

    func printCache() {
        print("Cache:", storage)
        print("Usage Order:", usageOrder)
    }
}

func testCache() {
    let cache = Cache<String, Int>(capacity: 3)

    // Add three values
    cache.set(10, forKey: "A")
    cache.set(20, forKey: "B")
    cache.set(30, forKey: "C")
    cache.printCache()
    /*
     Output=
     Cache:
     A -> 10
     B -> 20
     C -> 30
     
     Usage Order:
     A, B, C
    */

    // Access A
    print("Value for A:", cache.get("A") ?? -1)
    cache.printCache()
    /*
     A becomes most recently used.
     Usage Order:
     B, C, A
    */

    // Add D
    cache.set(40, forKey: "D")
    cache.printCache()

    /*
     Cache capacity is 3.
     Before adding D:
     B, C, A

     B is the least recently used,
     so B will be removed.
     Cache:
     A -> 10
     C -> 30
     D -> 40

     Usage Order:
     C, A, D
    */
}

