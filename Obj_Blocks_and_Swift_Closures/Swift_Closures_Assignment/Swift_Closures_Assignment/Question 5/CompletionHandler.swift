//
//  DataFetcher.swift
//  Swift_Closures_Assignment
//
//  Created by Mangesh Shiudkar on 26/08/26.
//

import Foundation

typealias CompletionHandler = (Data?, Error?) -> Void

class DataFetcher {
    var completion: CompletionHandler?

    func fetchData(completion: CompletionHandler) {
        let data = "Sample Data".data(using: .utf8)
        completion(data, nil)
    }
}

func testCompletionHandler() {
    let dataFetcher = DataFetcher()
    
    dataFetcher.completion = { data, error in
        if let error = error {
            print("Error: \(error)")
        } else if let data = data {
            print("Received Data: \(data)")
        }
    }

    dataFetcher.fetchData { data, error in
        if let error = error {
            print("Error: \(error)")
        } else if let data = data {
            print("Received Data: \(data)")
        }
    }
}
