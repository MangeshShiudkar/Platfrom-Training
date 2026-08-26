//
//  EscapingClosure.swift
//  Swift_Closures_Assignment
//
//  Created by Mangesh Shiudkar on 26/08/26.
//

import Foundation

class ClosureExample {
    func performSync(closure: () -> Void) {
        closure()
    }
    
    func performAsync(completion: @escaping () -> Void) {
        DispatchQueue.global().async {
            completion()
        }
    }
}

func testEscapingClosure() {
    let example = ClosureExample()
    example.performSync {
        print("performSync executed")
    }
    example.performAsync {
        print("performAsync executed")
    }
    sleep(2)
}
