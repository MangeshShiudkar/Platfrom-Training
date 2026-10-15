//
//  MyResult.swift
//  GenericAssignment
//
//  Created by Mangesh Shiudkar on 25/08/26.
//

import Foundation

enum MyResult<Success, Failure: Error> {
    case success(Success)
    case failure(Failure)
    
    func map<T>(_ transform: (Success) -> T) -> MyResult<T, Failure> {
        switch self {
        case .success(let value):
            return .success(transform(value))
        case .failure(let error):
            return .failure(error)
        }
    }
}

enum MyError: Error {
    case somethingWentWrong
}

func testMyResult() {
    // Success case
    let result: MyResult<Int, MyError> = .success(10)
    let newResult = result.map { $0 * 2 }
    print(newResult)
    /*
     Input:
     .success(10)

     Transformation:
     10 * 2

     Output:
     success(20)
     */

    // Failure case
    let failedResult: MyResult<Int, MyError> = .failure(.somethingWentWrong)
    let newFailedResult = failedResult.map { $0 * 2 }
    print(newFailedResult)
    /*
     Input:
     .failure(somethingWentWrong)

     Output:
     failure(somethingWentWrong)
     */
}
