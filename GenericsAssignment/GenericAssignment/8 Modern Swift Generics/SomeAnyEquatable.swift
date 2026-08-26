//
//  SomAnyEquatable.swift
//  GenericAssignment
//
//  Created by Mangesh Shiudkar on 25/08/26.
//

import Foundation

func checkWithSome<T: Equatable>(_ value: some Equatable, stored: T) -> Bool {
    guard let value = value as? T else {
        return false
    }
    return value == stored
}

func checkWithAny<T: Equatable>(_ value: any Equatable, stored: T) -> Bool {
    guard let value = value as? T else {
        return false
    }
    return value == stored
}

/*
 Use `some Equatable` when the concrete type is preserved by the compiler.
 Use `any Equatable` when the value is handled as a protocol existential
 and its concrete type is hidden.
 */

func testSomeAnyEquatable() {
    let storedNumber = 10
    let someResult = checkWithSome(10, stored: storedNumber)
    print("Using some:", someResult)
    let anyResult = checkWithAny(10,stored: storedNumber)
    print("Using any:", anyResult)
    /*
     Input:
     Passed value: 10
     Stored value: 10

     Output:
     Using some: true
     Using any: true
     */
}
