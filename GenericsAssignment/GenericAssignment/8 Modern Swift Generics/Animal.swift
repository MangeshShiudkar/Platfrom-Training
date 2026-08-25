//
//  Animal.swift
//  GenericAssignment
//
//  Created by Mangesh Shiudkar on 25/08/26.
//

import Foundation

protocol Animal {
    func describe()
}

struct Dog: Animal {
    func describe() {
        print("I am a Dog")
    }
}

struct Cat: Animal {
    func describe() {
        print("I am a Cat")
    }
}

struct Bird: Animal {
    func describe() {
        print("I am a Bird")
    }
}

func testAnimals() {
    let animals: [any Animal] = [
        Dog(),
        Cat(),
        Bird()
    ]
    for animal in animals {
        animal.describe()
    }
    /*
     Output:
     I am a Dog
     I am a Cat
     I am a Bird
     */
}
