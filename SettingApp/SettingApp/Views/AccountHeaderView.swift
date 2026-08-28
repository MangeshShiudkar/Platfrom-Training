//
//  AccountHeaderView.swift
//  SettingApp
//
//  Created by Mangesh Shiudkar on 28/08/26.
//

//
//  AccountHeaderView.swift
//  SettingApp
//
//  Created by Mangesh Shiudkar on 28/08/26.
//

import UIKit

class AccountHeaderView: UICollectionReusableView {
    
    // Identifier used to register and reuse the header
    static let identifier = "AccountHeaderView"
    
    // Background view for Apple Account icon
    private let accountIconView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .systemBlue
        
        view.layer.cornerRadius = 25
        
        view.clipsToBounds = true
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    // Image view used to display Apple logo
    private let appleImageView: UIImageView = {
        // Set size and weight for Apple logo
        let configuration = UIImage.SymbolConfiguration(
            pointSize: 20,
            weight: .medium
        )
        
        let imageView = UIImageView(
            image: UIImage(
                systemName: "apple.logo",
                withConfiguration: configuration
            )
        )
        
        imageView.tintColor = .white
        
        imageView.contentMode = .scaleAspectFit
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    // Label used to display Apple Account title
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Apple Account"
        
        label.font = .boldSystemFont(
            ofSize: 22
        )
        
        label.numberOfLines = 1
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // Label used to display account subtitle
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Sign in to access"
        
        label.numberOfLines = 0
        
        label.font = .systemFont(
            ofSize: 16
        )
        
        label.textColor = .secondaryLabel
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // Image view used to display right chevron
    private let chevronImageView: UIImageView = {
        // Set size and weight for chevron icon
        let configuration = UIImage.SymbolConfiguration(
            pointSize: 18,
            weight: .medium
        )
        
        let imageView = UIImageView(
            image: UIImage(
                systemName: "chevron.right",
                withConfiguration: configuration
            )
        )
        
        imageView.tintColor = .tertiaryLabel
        
        imageView.contentMode = .scaleAspectFit
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    override init(
        frame: CGRect
    ) {
        super.init(
            frame: frame
        )
        
        // Setup header UI
        setupUI()
        
        // Setup constraints for UI components
        setupConstraints()
    }
    
    required init?(
        coder: NSCoder
    ) {
        fatalError(
            "init(coder:) has not been implemented"
        )
    }
    
    private func setupUI() {
        // Set background color for Account header
        backgroundColor = .secondarySystemGroupedBackground
        
        // Set corner radius for header
        layer.cornerRadius = 20
        
        clipsToBounds = true
        
        // Add account icon view
        addSubview(
            accountIconView
        )
        
        // Add Apple logo inside account icon view
        accountIconView.addSubview(
            appleImageView
        )
        
        // Add title label
        addSubview(
            titleLabel
        )
        
        // Add subtitle label
        addSubview(
            subtitleLabel
        )
        
        // Add right chevron image
        addSubview(
            chevronImageView
        )
    }
    
    private func setupConstraints() {
        // Set constraints for all UI components
        NSLayoutConstraint.activate([
            
            // Account icon constraints
            accountIconView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 32
            ),
            
            accountIconView.centerYAnchor.constraint(
                equalTo: centerYAnchor
            ),
            
            accountIconView.widthAnchor.constraint(
                equalToConstant: 65
            ),
            
            accountIconView.heightAnchor.constraint(
                equalToConstant: 65
            ),
            
            // Apple logo constraints
            appleImageView.centerXAnchor.constraint(
                equalTo: accountIconView.centerXAnchor
            ),
            
            appleImageView.centerYAnchor.constraint(
                equalTo: accountIconView.centerYAnchor
            ),
            
            appleImageView.widthAnchor.constraint(
                equalToConstant: 45
            ),
            
            appleImageView.heightAnchor.constraint(
                equalToConstant: 45
            ),
            
            // Chevron image constraints
            chevronImageView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -24
            ),
            
            chevronImageView.centerYAnchor.constraint(
                equalTo: centerYAnchor
            ),
            
            chevronImageView.widthAnchor.constraint(
                equalToConstant: 20
            ),
            
            chevronImageView.heightAnchor.constraint(
                equalToConstant: 20
            ),
            
            // Title label constraints
            titleLabel.leadingAnchor.constraint(
                equalTo: accountIconView.trailingAnchor,
                constant: 30
            ),
            
            titleLabel.trailingAnchor.constraint(
                equalTo: chevronImageView.leadingAnchor,
                constant: -16
            ),
            
            titleLabel.topAnchor.constraint(
                equalTo: topAnchor,
                constant: 30
            ),
            
            // Subtitle label constraints
            subtitleLabel.leadingAnchor.constraint(
                equalTo: titleLabel.leadingAnchor
            ),
            
            subtitleLabel.trailingAnchor.constraint(
                equalTo: chevronImageView.leadingAnchor,
                constant: -16
            ),
            
            subtitleLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 5
            ),
            
            subtitleLabel.bottomAnchor.constraint(
                lessThanOrEqualTo: bottomAnchor,
                constant: -25
            )
        ])
    }
    
}
