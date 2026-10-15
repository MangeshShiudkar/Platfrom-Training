//
//  BinarySearch.swift
//  GenericAssignment
//
//  Created by Mangesh Shiudkar on 25/08/26.
//

import Foundation

func binarySearch<T>(_ array: [T], target: T) -> Int? where T: Comparable {
    var left = 0
    var right = array.count - 1

    while left <= right {
        let middle = (left + right) / 2
        if array[middle] == target {
            return middle
        } else if array[middle] < target {
            left = middle + 1
        } else {
            right = middle - 1
        }
    }
    return nil
}

func testBinarySearch() {
    let numbers = [10, 20, 30, 40, 50, 60]
    if let index = binarySearch(numbers, target: 40) {
        print("Element found at index:", index)
    } else {
        print("Element not found")
    }
    /*
     Input:
     Array: [10, 20, 30, 40, 50, 60]
     Target: 40

     Output:
     Element found at index: 3
     */

    // Test when element is not present
    if let index = binarySearch(numbers, target: 25) {
        print("Element found at index:", index)
    } else {
        print("Element not found")
    }

    /*
     Input:
     Target: 25

     Output:
     Element not found
     */
}
