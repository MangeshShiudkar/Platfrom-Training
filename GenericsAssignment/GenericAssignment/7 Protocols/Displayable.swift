//
//  Displayable.swift
//  GenericAssignment
//
//  Created by Mangesh Shiudkar on 25/08/26.
//

import Foundation

protocol Displayable {
    associatedtype Value
    func display(_ value: Value)
}

struct NumberDisplay: Displayable {
    func display(_ value: Int) {
        print("Number:", value)
    }
}

struct StringDisplay: Displayable {
    func display(_ value: String) {
        print("Text:", value)
    }
}

func testDisplayable() {
    let numberDisplay = NumberDisplay()
    numberDisplay.display(100)
    /*
     Input:
     100

     Output:
     Number: 100
     */
    
    let stringDisplay = StringDisplay()
    stringDisplay.display("Hello Swift")
    /*
     Input:
     Hello Swift

     Output:
     Text: Hello Swift
     */
}
