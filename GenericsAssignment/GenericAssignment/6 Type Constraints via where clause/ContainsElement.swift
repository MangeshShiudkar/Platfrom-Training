//
//  ContainsElement.swift
//  GenericAssignment
//
//  Created by Mangesh Shiudkar on 25/08/26.
//

import Foundation

func containsElement<T>(_ arr: [T], _ val: T) -> Bool where T: Equatable {
    for ele in arr {
        if ele == val {
            return true
        }
    }
    return false
}

func testContainsElement() {
    // Test with Int
    let numbers = [10, 20, 30, 40]
    let isPresent = containsElement(numbers, 20)
    print("Is 20 present:", isPresent)
    /*
     Input:
     Array: [10, 20, 30, 40]
     Value: 20
     
     Output:
     Is 20 present: true
     */
    
    // Test with String
    let names = ["Swift", "Java", "Kotlin"]
    let isNamePresent = containsElement(names, "Java")
    print("Is Java present:", isNamePresent)
    /*
     Output:
     Is Java present: true
     */
}
