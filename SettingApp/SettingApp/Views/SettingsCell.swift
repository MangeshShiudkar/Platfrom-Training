//
//  SettingsCell.swift
//  SettingApp
//
//  Created by Mangesh Shiudkar on 28/08/26.
//

import UIKit

class SettingsCell: UICollectionViewCell {
    
    // Identifier used to register and reuse the cell
    static let identifier = "SettingsCell"
    
    // Background view for the settings icon
    private let iconBackgroundView: UIView = {
        let view = UIView()
        
        view.layer.cornerRadius = 10
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    // Image view used to display the settings icon
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.tintColor = .white
        
        imageView.contentMode = .scaleAspectFit
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    // Label used to display the settings item title
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(
            ofSize: 20
        )
        
        label.textColor = .label
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // Image view used to display the right chevron
    private let chevronImageView: UIImageView = {
        let imageView = UIImageView(
            image: UIImage(
                systemName: "chevron.right"
            )
        )
        
        imageView.tintColor = .tertiaryLabel
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    // Button used to delete the settings item
    private let deleteButton: UIButton = {
        let button = UIButton(
            type: .system
        )
        
        // Set size and weight for delete icon
        let configuration = UIImage.SymbolConfiguration(
            pointSize: 15,
            weight: .regular
        )
        
        let image = UIImage(
            systemName: "trash",
            withConfiguration: configuration
        )
        
        button.setImage(
            image,
            for: .normal
        )
        
        button.tintColor = .systemRed
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    // Separator used between settings items
    private let separatorView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .separator
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    
    // Closure called when delete button is tapped
    var onDeleteTapped: (() -> Void)?
    
    
    override init(
        frame: CGRect
    ) {
        super.init(
            frame: frame
        )
        
        // Setup cell UI
        setupUI()
    }
    
    required init?(
        coder: NSCoder
    ) {
        fatalError(
            "init(coder:) has not been implemented"
        )
    }
    
    private func setupUI() {
        // Set background color for the cell
        backgroundColor = .secondarySystemGroupedBackground
        
        // Add icon background view
        contentView.addSubview(
            iconBackgroundView
        )
        
        // Add icon inside icon background view
        iconBackgroundView.addSubview(
            iconImageView
        )
        
        // Add title label
        contentView.addSubview(
            titleLabel
        )
        
        // Add right chevron image
        contentView.addSubview(
            chevronImageView
        )
        
        // Add delete button
        contentView.addSubview(
            deleteButton
        )
        
        // Add separator view
        contentView.addSubview(
            separatorView
        )
        
        // Set constraints for all UI components
        NSLayoutConstraint.activate([
            
            // Icon background constraints
            iconBackgroundView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 16
            ),
            
            iconBackgroundView.centerYAnchor.constraint(
                equalTo: contentView.centerYAnchor
            ),
            
            iconBackgroundView.widthAnchor.constraint(
                equalToConstant: 30
            ),
            
            iconBackgroundView.heightAnchor.constraint(
                equalToConstant: 30
            ),
            
            // Icon image constraints
            iconImageView.centerXAnchor.constraint(
                equalTo: iconBackgroundView.centerXAnchor
            ),
            
            iconImageView.centerYAnchor.constraint(
                equalTo: iconBackgroundView.centerYAnchor
            ),
            
            iconImageView.widthAnchor.constraint(
                equalToConstant: 24
            ),
            
            iconImageView.heightAnchor.constraint(
                equalToConstant: 24
            ),
            
            // Title label constraints
            titleLabel.leadingAnchor.constraint(
                equalTo: iconBackgroundView.trailingAnchor,
                constant: 14
            ),
            
            titleLabel.centerYAnchor.constraint(
                equalTo: contentView.centerYAnchor
            ),
            
            // Delete button constraints
            deleteButton.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -12
            ),
            
            deleteButton.centerYAnchor.constraint(
                equalTo: contentView.centerYAnchor
            ),
            
            // Chevron image constraints
            chevronImageView.trailingAnchor.constraint(
                equalTo: deleteButton.leadingAnchor,
                constant: -12
            ),
            
            chevronImageView.centerYAnchor.constraint(
                equalTo: contentView.centerYAnchor
            ),
            
            // Separator constraints
            separatorView.leadingAnchor.constraint(
                equalTo: titleLabel.leadingAnchor
            ),
            
            separatorView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor
            ),
            
            separatorView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor
            ),
            
            separatorView.heightAnchor.constraint(
                equalToConstant: 0.5
            )
        ])
        
        // Add action for delete button
        deleteButton.addTarget(
            self,
            action: #selector(
                deleteTapped
            ),
            for: .touchUpInside
        )
    }
    
    func configure(
        item: SettingsItem,
        isLastItem: Bool
    ) {
        // Set settings item title
        titleLabel.text = item.title
        
        // Set settings item icon
        iconImageView.image = UIImage(
            systemName: item.icon
        )
        
        // Set background color for the icon
        iconBackgroundView.backgroundColor = color(
            from: item.iconColorName
        )
        
        // Hide separator for the last item
        separatorView.isHidden = isLastItem
    }
    
    private func color(
        from name: String
    ) -> UIColor {
        
        // Return color based on color name
        switch name {
            
        case "gray":
            return .systemGray
            
        case "red":
            return .systemRed
            
        case "orange":
            return .systemOrange
            
        case "green":
            return .systemGreen
            
        case "purple":
            return .systemPurple
            
        case "pink":
            return .systemPink
            
        default:
            return .systemBlue
        }
    }
    
    @objc private func deleteTapped() {
        // Call closure when delete button is tapped
        onDeleteTapped?()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // Remove previous delete action before reusing cell
        onDeleteTapped = nil
    }
}
