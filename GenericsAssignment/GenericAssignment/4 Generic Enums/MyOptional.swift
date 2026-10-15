//
//  MyOptional.swift
//  GenericAssignment
//
//  Created by Mangesh Shiudkar on 25/08/26.
//

import Foundation

enum MyOptional<Wrapped> {
    case some(Wrapped)
    case none

    func map<T>(_ transform: (Wrapped) -> T) -> MyOptional<T> {
        switch self {
        case .some(let value):
            return .some(transform(value))
        case .none:
            return .none
        }
    }
}

func testMyOptional() {
    let number: MyOptional<Int> = .some(10)
    let result = number.map { value in
        "Number is \(value)"
    }
    
    switch result {
    case .some(let value):
        print(value)
    case .none:
        print("No value")
    }
    /*
     Input:
     10

     Output:
     Number is 10
     */

    // Input without a value
    let emptyValue: MyOptional<Int> = .none
    let emptyResult = emptyValue.map { value in
        value * 2
    }
    
    switch emptyResult {
    case .some(let value):
        print(value)
    case .none:
        print("No value")
    }
    /*
     Output:
     No value
     */
}
