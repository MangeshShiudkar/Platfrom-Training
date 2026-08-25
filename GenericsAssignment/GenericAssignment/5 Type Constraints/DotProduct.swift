//
//  DotProduct.swift
//  GenericAssignment
//
//  Created by Mangesh Shiudkar on 25/08/26.
//

import Foundation

func dotProduct<T: Numeric>(_ first: [T], _ second: [T]) -> T? {
    guard first.count == second.count else {
        print("Arrays must have the same length")
        return nil
    }
    var result: T = 0
    for index in 0..<first.count {
        result += first[index] * second[index]
    }
    return result
}

func testDotProduct() {
    let firstArray = [1, 2, 3]
    let secondArray = [4, 5, 6]
    if let result = dotProduct(firstArray, secondArray) {
        print("Dot Product:", result)
    }
    /*
     Input:
     
     First Array:  [1, 2, 3]
     Second Array: [4, 5, 6]
     
     Calculation:
     (1 * 4) + (2 * 5) + (3 * 6) = 4 + 10 + 18
     
     Output:
     Dot Product: 32
     */
}
