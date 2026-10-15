//
//  MakeSequence.swift
//  GenericAssignment
//
//  Created by Mangesh Shiudkar on 25/08/26.
//

import Foundation

func makeSequence(_ n: Int) -> some Sequence {
    return 1...n
}

func testMakeSequence() {
    let sequence = makeSequence(5)
    
    for num in sequence {
        print(num)
    }
    /*
     Input:
     5
     
     Output:
     1
     2
     3
     4
     5
     */
}
