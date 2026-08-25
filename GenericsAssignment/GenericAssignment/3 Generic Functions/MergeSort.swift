//
//  MergeSort.swift
//  GenericAssignment
//
//  Created by Mangesh Shiudkar on 25/08/26.
//

import Foundation

func mergeSort<T: Comparable>(_ array: [T]) -> [T] {
    guard array.count > 1 else {
        return array
    }
    let middle = array.count / 2
    let left = Array(array[..<middle])
    let right = Array(array[middle...])
    let sortedLeft = mergeSort(left)
    let sortedRight = mergeSort(right)
    return merge(sortedLeft, sortedRight)
}

func merge<T: Comparable>(_ left: [T], _ right: [T]) -> [T] {
    var result: [T] = []
    var leftIndex = 0
    var rightIndex = 0
    
    while leftIndex < left.count && rightIndex < right.count {
        if left[leftIndex] <= right[rightIndex] {
            result.append(left[leftIndex])
            leftIndex += 1
        } else {
            result.append(right[rightIndex])
            rightIndex += 1
        }
    }

    while leftIndex < left.count {
        result.append(left[leftIndex])
        leftIndex += 1
    }

    while rightIndex < right.count {
        result.append(right[rightIndex])
        rightIndex += 1
    }

    return result
}

func testMergeSort() {
    // Input: Integer array
    let numbers = [38, 27, 43, 3, 9, 82, 10]
    let sortedNumbers = mergeSort(numbers)
    print("Original Array:", numbers)
    print("Sorted Array:", sortedNumbers)
    /*
     Input:
     [38, 27, 43, 3, 9, 82, 10]

     Output:
     [3, 9, 10, 27, 38, 43, 82]
     */

    // Input: String array
    let names = ["Swift", "Apple", "Generics", "Code"]
    let sortedNames = mergeSort(names)
    print("Original Array:", names)
    print("Sorted Array:", sortedNames)
    /*
     Output:
     ["Apple", "Code", "Generics", "Swift"]
     */
}
