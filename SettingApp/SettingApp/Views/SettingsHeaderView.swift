//
//  SettingsHeaderView.swift
//  SettingApp
//
//  Created by Mangesh Shiudkar on 28/08/26.
//

import UIKit

class SettingsHeaderView: UICollectionReusableView {
    
    // Identifier used to register and reuse the header
    static let identifier = "SettingsHeaderView"
    
    // Button used to expand or collapse the section
    private let expandButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        
        // Set font for section title
        configuration.titleTextAttributesTransformer =
        UIConfigurationTextAttributesTransformer {
            incoming in
            
            var outgoing = incoming
            outgoing.font = .boldSystemFont(
                ofSize: 20
            )
            
            return outgoing
        }
        
        let button = UIButton(
            configuration: configuration
        )
        
        button.contentHorizontalAlignment = .leading
        
        button.translatesAutoresizingMaskIntoConstraints =
        false
        
        return button
    }()
    
    // Button used to add a new item in the section
    private let addButton: UIButton = {
        let button = UIButton(
            type: .system
        )
        
        button.setImage(
            UIImage(
                systemName: "plus.circle"
            ),
            for: .normal
        )
        
        button.tintColor = .systemBlue
        
        button.translatesAutoresizingMaskIntoConstraints =
        false
        
        return button
    }()
    
    // Button used to delete the section
    private let deleteButton: UIButton = {
        let button = UIButton(
            type: .system
        )
        
        let configuration =
        UIImage.SymbolConfiguration(
            pointSize: 17,
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
        
        button.translatesAutoresizingMaskIntoConstraints =
        false
        
        return button
    }()
    
    // Closure called when expand button is tapped
    var onExpandTapped: (() -> Void)?
    
    // Closure called when add button is tapped
    var onAddTapped: (() -> Void)?
    
    // Closure called when delete button is tapped
    var onDeleteTapped: (() -> Void)?
    
    override init(
        frame: CGRect
    ) {
        super.init(
            frame: frame
        )
        
        // Setup header UI
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
        // Add all buttons to header view
        addSubview(
            expandButton
        )
        
        addSubview(
            addButton
        )
        
        addSubview(
            deleteButton
        )
        
        // Set constraints for all buttons
        NSLayoutConstraint.activate([
            
            // Expand button constraints
            expandButton.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 16
            ),
            
            expandButton.centerYAnchor.constraint(
                equalTo: centerYAnchor
            ),
            
            expandButton.trailingAnchor.constraint(
                lessThanOrEqualTo:
                    addButton.leadingAnchor,
                constant: -10
            ),
            
            // Add button constraints
            addButton.trailingAnchor.constraint(
                equalTo:
                    deleteButton.leadingAnchor,
                constant: -16
            ),
            
            addButton.centerYAnchor.constraint(
                equalTo: centerYAnchor
            ),
            
            // Delete button constraints
            deleteButton.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -16
            ),
            
            deleteButton.centerYAnchor.constraint(
                equalTo: centerYAnchor
            )
        ])
        
        // Add action for expand button
        expandButton.addTarget(
            self,
            action: #selector(
                expandTapped
            ),
            for: .touchUpInside
        )
        
        // Add action for add button
        addButton.addTarget(
            self,
            action: #selector(
                addTapped
            ),
            for: .touchUpInside
        )
        
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
        title: String,
        isExpanded: Bool
    ) {
        // Change chevron image based on section state
        let imageName =
        isExpanded
        ? "chevron.down"
        : "chevron.right"
        
        // Set expand or collapse image
        expandButton.setImage(
            UIImage(
                systemName: imageName
            ),
            for: .normal
        )
        
        // Set section title
        expandButton.setTitle(
            "  \(title)",
            for: .normal
        )
    }
    
    @objc private func expandTapped() {
        // Call closure when expand button is tapped
        onExpandTapped?()
    }
    
    @objc private func addTapped() {
        // Call closure when add button is tapped
        onAddTapped?()
    }
    
    @objc private func deleteTapped() {
        // Call closure when delete button is tapped
        onDeleteTapped?()
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // Remove previous closures before reusing header
        onExpandTapped = nil
        onAddTapped = nil
        onDeleteTapped = nil
    }
}
