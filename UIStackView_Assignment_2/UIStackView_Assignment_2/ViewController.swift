//
//  ViewController.swift
//  UIStackView_Assignment_2
//
//  Created by Mangesh Shiudkar on 02/09/26.
//

import UIKit

class ViewController: UIViewController {
    
    // Maximum number of views that can be added to the stack view.
    private let maxCount = 6
    
    // Stack view used to manage the added views vertically.
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 16
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupNavigationBar()
    }
    
    // Setup the main UI and apply constraints to the stack view.
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])
    }
    
    // Setup navigation bar with Add and Remove buttons.
    private func setupNavigationBar() {
        navigationItem.title = "Stack Views"
        
        let plusButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addViewTapped))
        let minusButton = UIBarButtonItem(title: "-", style: .plain, target: self, action: #selector(removeViewTapped))
        
        navigationItem.rightBarButtonItems = [plusButton,minusButton]
    }
    
    // Add a new view to the stack view until it reaches the maximum limit.
    @objc private func addViewTapped() {
        guard stackView.arrangedSubviews.count < maxCount else {
            return
        }
        
        let newView = createNewView()
        stackView.addArrangedSubview(newView)
        newView.alpha = 0
        
        UIView.animate(withDuration: 0.3) {
            newView.alpha = 1
            self.view.layoutIfNeeded()
        }
    }
    
    // Remove the last added view from the stack view with animation.
    @objc private func removeViewTapped() {
        guard let lastView = stackView.arrangedSubviews.last else {
            return
        }
        stackView.removeArrangedSubview(lastView)
        
        UIView.animate(withDuration: 0.3, animations: {
            lastView.alpha = 0
            self.view.layoutIfNeeded()
            
        },
                       completion: { _ in
            
            lastView.removeFromSuperview()
        }
        )
    }
    
    // Create a new view with different color, rounded corners and fixed height.
    private func createNewView() -> UIView {
        let view = UIView()
        let colors: [UIColor] = [.systemRed, .systemBlue, .systemYellow, .systemBrown, .systemMint, .systemOrange]
        view.backgroundColor = colors[stackView.arrangedSubviews.count]
        view.layer.cornerRadius = 12
        view.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        return view
    }

}

