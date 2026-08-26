//
//  NetworkManagerOptional.swift
//  Swift_Closures_Assignment
//
//  Created by Mangesh Shiudkar on 26/08/26.
//


// Solution 1: Using [weak self] with optional chaining
class NetworkManagerOptional {
    var onComplete: (() -> Void)?
    
    func startRequest() {
        onComplete = { [weak self] in
            self?.processData()
        }
    }

    func processData() {
        print("Processing Data")
    }
}


// Solution 2: Using [weak self] with guard let
class NetworkManagerGuard {
    var onComplete: (() -> Void)?
    
    func startRequest() {
        onComplete = { [weak self] in
            guard let self = self else {
                return
            }

            self.processData()
        }
    }

    func processData() {
        print("Processing Data")
    }
}

/*
 Prefer optional chaining when only one or a few operations need self,
 because it is shorter and simpler.

 Prefer guard let self = self else { return } when multiple operations
 need self, because self can then be used normally without optional
 chaining repeatedly.
*/
