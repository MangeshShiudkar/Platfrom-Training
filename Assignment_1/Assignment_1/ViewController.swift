//
//  ViewController.swift
//  Assignment_1
//
//  Created by Mangesh Shiudkar on 02/09/26.
//

import UIKit

class ViewController: UIViewController {
    
    // Used to check whether the description is expanded or collapsed
    private var isExpanded = false
    
    // Main container view to give background color, border and corner radius
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray4.cgColor
        
        return view
    }()
    
    // Label used to display the description text
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
        label.font = .systemFont(ofSize: 17)
        label.numberOfLines = 2
        label.textAlignment = .justified
        label.textColor = .label
    
        return label
    }()
    
    // Button used to expand and collapse the description
    private let readMoreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Read More", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemBlue.cgColor
        
        return button
    }()
    
    // Stack view used to arrange the description label
    // and Read More button vertically
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [descriptionLabel, readMoreButton])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 16
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupActions()
    }
    
    // Setup all views and Auto Layout constraints
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(containerView)
        containerView.addSubview(stackView)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10)
        ])
    }
    
    // Setup Read More / Read Less button action
    private func setupActions() {
        readMoreButton.addTarget(self, action: #selector(readMoreButtonTapped), for: .touchUpInside)
    }
    
    // Expand or collapse description and animate layout changes
    @objc private func readMoreButtonTapped() {
        view.layoutIfNeeded()
        isExpanded.toggle()
        descriptionLabel.numberOfLines = isExpanded ? 0 : 2
        
        let buttonTitle = isExpanded ? "Read Less" : "Read More"
        readMoreButton.setTitle(buttonTitle, for: .normal)
        
        // Animate the label and container height change
        UIView.animate( withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}

