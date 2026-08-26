//
//  DownloadViewController.swift
//  Swift_Closures_Assignment
//
//  Created by Mangesh Shiudkar on 26/08/26.
//
import UIKit

class DownloadViewController: UIViewController {

    let networkClient: NetworkClient
    var completionClosure: (() -> Void)?

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    func startDownload() {
        networkClient.fetchData { [weak self] in
            guard let self = self else {
                return
            }
            self.completionClosure = { [weak self] in
                self?.updateUI()
            }
        }
    }

    func updateUI() {
        print("Updating UI")
    }
}
