//
//  GenericLinkedList.swift
//  GenericAssignment
//
//  Created by Mangesh Shiudkar on 25/08/26.
//

import Foundation

struct LinkedList<Element: Equatable> {

    private class Node {
        var value: Element
        var next: Node?
        init(value: Element) {
            self.value = value
        }
    }

    private var head: Node?
    
    mutating func insert(_ value: Element) {
        let newNode = Node(value: value)
        guard let head else {
            self.head = newNode
            return
        }
        var current = head
        while let nextNode = current.next {
            current = nextNode
        }
        current.next = newNode
    }

    mutating func delete(_ value: Element) {
        guard let head else {
            return
        }
        if head.value == value {
            self.head = head.next
            return
        }
        var current: Node? = head
        while let currentNode = current, let nextNode = currentNode.next {
            if nextNode.value == value {
                currentNode.next = nextNode.next
                return
            }
            current = nextNode
        }
    }

    func contains(_ value: Element) -> Bool {
        var current = head
        while let currentNode = current {
            if currentNode.value == value {
                return true
            }
            current = currentNode.next
        }
        return false
    }

    func printList() {
        var current = head
        while let currentNode = current {
            print(currentNode.value)
            current = currentNode.next
        }
    }
}

func testLinkedList() {
    var list = LinkedList<Int>()
    // Insert elements
    list.insert(10)
    list.insert(20)
    list.insert(30)
    print("Linked List:")
    list.printList()
    /*
     Input:
     10, 20, 30

     Output:
     10
     20
     30
     */

    // Search for an element
    let isFound = list.contains(20)
    print("Is 20 present:", isFound)
    /*
     Output:
     Is 20 present: true
     */

    // Delete an element
    list.delete(20)

    print("After deleting 20:")
    list.printList()
    /*
     Output:
     10
     30
     */
}
