//
//  ViewController.swift
//  UIStackView_Assignment_3
//
//  Created by Mangesh Shiudkar on 02/09/26.
//

import UIKit

class ViewController: UIViewController {
    
    // Tracks the currently displayed layout.
    // false = Layout 1
    // true = Layout 2
    private var isLayoutTwo = false
    
    // Fixed avatar image displayed on the left side.
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle.fill")
        imageView.tintColor = .systemBlue
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    // Title displayed in both Layout 1 and Layout 2.
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Mangesh Shiudkar"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 1
        
        return label
    }()
    
    // Displays follower count in Layout 1
    // and connection count in Layout 2.
    private let countLabel: UILabel = {
        let label = UILabel()
        label.text = "10 Followers"
        label.numberOfLines = 1
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 15)
        label.lineBreakMode = .byTruncatingTail
        
        return label
    }()
    
    // Same button is reused in both layouts.
    // Layout 1 -> Connect
    // Layout 2 -> Follow
    private let actionButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Connect"
        configuration.baseBackgroundColor = .systemBlue
        configuration.baseForegroundColor = .white
        configuration.cornerStyle = .medium
        let button = UIButton(configuration: configuration)
        
        return button
    }()
    
    // multiline description.
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = """
            iOS Developer currently learning UIKit and building applications using Swift. Interested in improving UI development skills and understanding Auto Layout and UIStackView.
            """
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .justified
        label.textColor = .label
        label.numberOfLines = 0
        
        return label
    }()
    
    // Main horizontal stack that contains:
    // 1. Avatar image
    // 2. Complete profile content
    private let outerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.distribution = .fill
        stackView.spacing = 12
        
        return stackView
    }()
    
    // Left vertical stack.
    //
    // Layout 1:
    // Contains only the title.
    //
    // Layout 2:
    // Contains the title and connection count.
    private let leftInnerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 12
        
        return stackView
    }()
    
    // Right vertical stack.
    //
    // Layout 1:
    // Contains the follower count.
    //
    // Layout 2:
    // Contains the Follow button.
    private let rightInnerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .trailing
        stackView.distribution = .fill
        stackView.spacing = 12
        
        return stackView
    }()
    
    // Horizontal stack that manages the profile information.
    private let profileStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 12
        
        return stackView
    }()
    
    // Main vertical stack that manages the content
    // displayed beside the avatar.
    private let mainStackView: UIStackView = {
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
        setupInitialLayout()
        setupActions()
    }
    
    // Sets up the outer stack view and positions it
    // on the screen using Auto Layout.
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(outerStackView)
        
        outerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            outerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            outerStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            outerStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
    }
    
    // Creates the initial Layout 1.
    //
    // Layout 1:
    //
    // Avatar | Title      Followers
    //        | Connect Button
    //        | Description
    private func setupInitialLayout() {
        
        leftInnerStackView.addArrangedSubview(titleLabel)
        rightInnerStackView.addArrangedSubview(countLabel)
        
        profileStackView.addArrangedSubview(leftInnerStackView)
        profileStackView.addArrangedSubview(rightInnerStackView)
        
        mainStackView.addArrangedSubview(profileStackView)
        mainStackView.addArrangedSubview(actionButton)
        mainStackView.addArrangedSubview(descriptionLabel)
        
        outerStackView.addArrangedSubview(avatarImageView)
        outerStackView.addArrangedSubview(mainStackView)
        
        avatarImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        avatarImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        titleLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        countLabel.setContentHuggingPriority(.required, for: .horizontal)
        countLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
    // Adds the button tap action.
    private func setupActions(){
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }
    
    // Toggles between Layout 1 and Layout 2.
    @objc private func actionButtonTapped() {
        isLayoutTwo.toggle()
        if isLayoutTwo {
            switchToLayoutTwo()
        }else {
            switchToLayoutOne()
        }
    }
    
    // Changes Layout 1 into Layout 2.
    //
    // Layout 2:
    //
    // Avatar | Title          Follow
    //        | Connections
    //        | Description
    private func switchToLayoutTwo() {
        view.layoutIfNeeded()
        
        rightInnerStackView.removeArrangedSubview(countLabel)
        countLabel.removeFromSuperview()
        
        mainStackView.removeArrangedSubview(actionButton)
        actionButton.removeFromSuperview()
        
        countLabel.text = "1245 Connections"
        actionButton.configuration?.title = "Follow"
        
        leftInnerStackView.addArrangedSubview(countLabel)
        rightInnerStackView.addArrangedSubview(actionButton)
        
        actionButton.setContentHuggingPriority(.required, for: .horizontal)
        actionButton.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        countLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        countLabel.setContentCompressionResistancePriority(.defaultLow,for: .horizontal)
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    // Changes Layout 2 back into Layout 1.
    private func switchToLayoutOne() {
        view.layoutIfNeeded()
        
        leftInnerStackView.removeArrangedSubview(countLabel)
        countLabel.removeFromSuperview()
        
        rightInnerStackView.removeArrangedSubview(actionButton)
        actionButton.removeFromSuperview()
        
        countLabel.text = "10 Followers"
        actionButton.configuration?.title = "Connect"
        
        rightInnerStackView.addArrangedSubview(countLabel)
        
        mainStackView.insertArrangedSubview(actionButton,at: 1)
        
        titleLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        countLabel.setContentHuggingPriority(.required, for: .horizontal)
        countLabel.setContentCompressionResistancePriority(.required,for: .horizontal)
        
        // Animate the layout change.
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}

