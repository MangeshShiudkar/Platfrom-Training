//
//  GenericPoint.swift
//  GenericAssignment
//
//  Created by Mangesh Shiudkar on 25/08/26.
//

import Foundation

struct Point<T: FloatingPoint> {
    
    let x: T
    let y: T

    func distance(_ point: Point<T>) -> T {
        let xDiff = point.x - x
        let yDiff = point.y - y
        let squareDistance = (xDiff * xDiff) + (yDiff * yDiff)
        return squareDistance.squareRoot()
    }
}

func testPoint() {
    let point1 = Point<Double>(x: 3.0, y: 4.0)
    let point2 = Point<Double>(x: 0.0, y: 0.0)
    let distance = point1.distance(point2)

    print("Distance:", distance)
    /*
     Output:
     Distance: 5.0
    */
}
