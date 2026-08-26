//
//  CustomIntegerArray.swift
//  Swift_Closures_Assignment
//
//  Created by Mangesh Shiudkar on 26/08/26.
//


typealias FilterPredicateClosure = (Int) -> Bool

typealias ReduceClosure = (Int, Int) -> Int

typealias SortClosure = (Int, Int) -> Bool

typealias ForEachClosure = (Int) -> Void


class CustomIntegerArray {

    private var storage: [Int]

    init(values: [Int]) {
        storage = values
    }

    func filter(_ predicate: FilterPredicateClosure) -> CustomIntegerArray {
        var result: [Int] = []
        
        for value in storage {
            if predicate(value) {
                result.append(value)
            }
        }
        return CustomIntegerArray(values: result)
    }

    func reduce(_ operation: ReduceClosure, initialValue: Int) -> Int {
        var result = initialValue

        for value in storage {
            result = operation(result, value)
        }
        return result
    }

    func sorted(by comparison: SortClosure) -> CustomIntegerArray {
        var result = storage

        for i in 0..<result.count {
            for j in (i + 1)..<result.count {
                if comparison(result[j], result[i]) {
                    let temp = result[i]
                    result[i] = result[j]
                    result[j] = temp
                }
            }
        }
        return CustomIntegerArray(values: result)
    }

    func forEach(_ operation: ForEachClosure) {
        for value in storage {
            operation(value)
        }
    }
}


extension CustomIntegerArray: CustomStringConvertible {
    var description: String {
        return "\(storage)"
    }
}


func testCustomIntegerArray() {
    let numbers = CustomIntegerArray(
        values: [5, 2, 8, 1, 9, 3]
    )

    // 1. Filter
    let evens = numbers.filter { value in
        return value % 2 == 0
    }
    print("Evens: \(evens)")
    
    // 2. Reduce
    let sum = numbers.reduce(
        { partial, value in
            return partial + value
        },
        initialValue: 0
    )
    print("Sum: \(sum)")
    
    
    // 3. Sorted
    let sorted = numbers.sorted { a, b in
        return a < b
    }
    print("Sorted: \(sorted)")
    
    
    // 4. ForEach
    numbers.forEach { value in
        print("Value: \(value)")
    }
}
