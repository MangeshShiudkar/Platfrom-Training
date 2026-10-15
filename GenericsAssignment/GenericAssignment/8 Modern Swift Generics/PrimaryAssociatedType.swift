//
//  PrimaryAssociatedType.swift
//  GenericAssignment
//
//  Created by Mangesh Shiudkar on 25/08/26.
//

import Foundation

protocol Container1<Item> {
    associatedtype Item
    mutating func add(_ item: Item)
    mutating func remove(at index: Int)
    subscript(index: Int) -> Item { get }
    var count: Int { get }
}

struct ItemContainer1<T>: Container1 {
    private var items: [T] = []

    mutating func add(_ item: T) {
        items.append(item)
    }

    mutating func remove(at index: Int) {
        items.remove(at: index)
    }

    subscript(index: Int) -> T {
        return items[index]
    }

    var count: Int {
        return items.count
    }
}

func sum(_ c: some Container1<Int>) -> Int {
    var total = 0
    for index in 0..<c.count {
        total += c[index]
    }
    return total
}

func testPrimaryAssociatedType() {
    var container = ItemContainer1<Int>()
    container.add(10)
    container.add(20)
    container.add(30)
    let result = sum(container)
    print("Sum:", result)
    /*
     Input:
     10, 20, 30

     Calculation:
     10 + 20 + 30

     Output:
     Sum: 60
     */
}
