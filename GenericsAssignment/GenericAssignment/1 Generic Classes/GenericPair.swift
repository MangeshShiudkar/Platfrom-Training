//
//  GenericPair.swift
//  GenericAssignment
//
//  Created by Mangesh Shiudkar on 25/08/26.
//

import Foundation

class Pair<First,Second>{
    private var first: First
    private var second: Second
    
    init(first: First, second: Second) {
        self.first = first
        self.second = second
    }
    
    func setValues(_ a: First, _ b: Second) {
        first = a
        second = b
    }
    
    func getValues()-> (First,Second) {
        return (first,second)
    }
}

func testPair() {
    //input
    let pair = Pair(first: 10, second: "Swift")
    let values = pair.getValues()

    //Output = (10, "Swift")
    print(values)
}



