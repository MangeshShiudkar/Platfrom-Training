//
//  FindMax.swift
//  GenericAssignment
//
//  Created by Mangesh Shiudkar on 25/08/26.
//

import Foundation

import Foundation

func findMaximum<T: Comparable>(_ arr: [T]) -> T? {
    guard var max = arr.first else {
        return nil
    }
    
    for ele in arr {
        if ele > max {
            max = ele
        }
    }
    return max
}

func testFindMaximum() {
    // Test with Int
    let numbers = [10, 50, 20, 80, 30]
    if let maximum = findMaximum(numbers) {
        print("Maximum number:", maximum)
    }
    /*
     Input:
     [10, 50, 20, 80, 30]

     Output:
     Maximum number: 80
     */
    
    // Test with String
    let names = ["Apple", "Swift", "Generics", "Code"]
    if let maximum = findMaximum(names) {
        print("Maximum string:", maximum)
    }
    /*
     Output:
     Maximum string: Swift
     */
}
