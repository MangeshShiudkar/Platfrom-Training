//
//  Container.swift
//  GenericAssignment
//
//  Created by Mangesh Shiudkar on 25/08/26.
//

import Foundation

protocol Container {
    associatedtype Item
    mutating func add(_ item: Item)
    mutating func remove(at index: Int)
    subscript(index: Int) -> Item { get }
    var count: Int { get }
}

struct ItemContainer<T>: Container {
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

func testContainer() {
    var container = ItemContainer<Int>()
    container.add(10)
    container.add(20)
    container.add(30)
    /*
     Input:
     10, 20, 30
     */

    print("Item at index 1:", container[1])
    /*
     Output:
     Item at index 1: 20
     */

    print("Total count:", container.count)
    /*
     Output:
     Total count: 3
     */

    container.remove(at: 1)
    print("After removing index 1:")
    print("Item at index 0:", container[0])
    print("Item at index 1:", container[1])
    print("Total count:", container.count)
    /*
     Output:
     After removing index 1:
     Item at index 0: 10
     Item at index 1: 30
     Total count: 2
     */
}
