//
//  PrintArray.swift
//  GenericAssignment
//
//  Created by Mangesh Shiudkar on 25/08/26.
//

import Foundation

func printArray<T>(_ arr: [T]) {
    for ele in arr {
        print(ele)
    }
}

func testPrintArray() {
    // Input: Int array
    let numbers = [10, 20, 30]
    print("Integer Array:")
    printArray(numbers)
    /*
     Output:
     Integer Array:
     10
     20
     30
     */

    // Input: String array
    let names = ["UIKIT", "Swift", "Generics"]
    print("String Array:")
    printArray(names)
    /*
     Output:
     String Array:
     UIKIT
     Swift
     Generics
     */
}
