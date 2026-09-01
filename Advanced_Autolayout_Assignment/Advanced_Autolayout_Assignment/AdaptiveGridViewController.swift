//
//  AdaptiveGridViewController.swift
//  Advanced_Autolayout_Assignment
//
//  Created by Mangesh Shiudkar on 31/08/26.
//

import UIKit

final class AdaptiveGridViewController: UIViewController {

    // Provided: the four cards, already built and styled.
    private let cards: [CardView] = [
        CardView(title: "Skeleton", imageName: "skeleton", background: .systemGreen),
        CardView(title: "Owl",      imageName: "owl",      background: .systemRed),
        CardView(title: "Panda",    imageName: "panda",    background: .systemPurple),
        CardView(title: "Monkey",   imageName: "monkey",   background: .systemOrange),
    ]

    private var topLeft: CardView     { cards[0] }
    private var topRight: CardView    { cards[1] }
    private var bottomLeft: CardView  { cards[2] }
    private var bottomRight: CardView { cards[3] }

    // Populate these three arrays in TODO 1.
    private var sharedConstraints: [NSLayoutConstraint] = []
    private var compactConstraints: [NSLayoutConstraint] = []
    private var regularConstraints: [NSLayoutConstraint] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        cards.forEach(view.addSubview)

        setupConstraints()
        NSLayoutConstraint.activate(sharedConstraints)
        applyLayout(for: traitCollection)

        // TODO 2 — Register for the trait changes this screen depends on, so
        // that applyLayout(for:) runs whenever they change.
        //
        // Use registerForTraitChanges(_:handler:). Do NOT override the
        // deprecated traitCollectionDidChange(_:).
        
        registerForTraitChanges([UITraitHorizontalSizeClass.self]) { (self: Self, _) in
            self.applyLayout(for: self.traitCollection)
        }
    }

    private func setupConstraints() {
        let guide = view.safeAreaLayoutGuide

        // TODO 1 — Build the 2 x 2 grid.
        //
        //   sharedConstraints: everything true in BOTH configurations —
        //     the grid fills the safe area, and all four cards are equal in
        //     width and equal in height. Express "equal" as constraints
        //     BETWEEN the cards. No hard-coded widths or heights: the cards
        //     must re-proportion themselves as the available space changes.
        //
        //   compactConstraints / regularConstraints: any constraints that
        //     differ between the two size classes — for example the spacing
        //     between cards, which should be tighter in compact width.
        //
        // Hint: with equal widths/heights and a full-safe-area grid, most of
        // your work belongs in sharedConstraints.
        
        sharedConstraints = [
            
            // Outer edges of the grid
            topLeft.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            topLeft.topAnchor.constraint(equalTo: guide.topAnchor),
            
            topRight.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            topRight.topAnchor.constraint(equalTo: guide.topAnchor),
            
            bottomLeft.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            bottomLeft.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            
            bottomRight.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            bottomRight.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            
            // Equal widths
            topLeft.widthAnchor.constraint(equalTo: topRight.widthAnchor),
            topLeft.widthAnchor.constraint(equalTo: bottomLeft.widthAnchor),
            topLeft.widthAnchor.constraint(equalTo: bottomRight.widthAnchor),
            
            // Equal heights
            topLeft.heightAnchor.constraint(equalTo: topRight.heightAnchor),
            topLeft.heightAnchor.constraint(equalTo: bottomLeft.heightAnchor),
            topLeft.heightAnchor.constraint(equalTo: bottomRight.heightAnchor)
        ]
         
        //Compact Width Constraints
        compactConstraints = [
            
            // Horizontal spacing
            topLeft.trailingAnchor.constraint(equalTo: topRight.leadingAnchor,constant: -8),
            bottomLeft.trailingAnchor.constraint(equalTo: bottomRight.leadingAnchor,constant: -8),
            
            // Vertical spacing
            topLeft.bottomAnchor.constraint(equalTo: bottomLeft.topAnchor,constant: -8),
            topRight.bottomAnchor.constraint(equalTo: bottomRight.topAnchor,constant: -8)
        ]
        
        //Regular Width Constraints
        regularConstraints = [
            
            // Horizontal spacing
            topLeft.trailingAnchor.constraint(equalTo: topRight.leadingAnchor,constant: -20),
            bottomLeft.trailingAnchor.constraint(equalTo: bottomRight.leadingAnchor,constant: -20),

            // Vertical spacing
            topLeft.bottomAnchor.constraint(equalTo: bottomLeft.topAnchor,constant: -20),
            topRight.bottomAnchor.constraint(equalTo: bottomRight.topAnchor,constant: -20)
        ]
    }

    /// Provided — activates the correct set. Deactivate before activating so
    /// the two variable sets are never simultaneously active.
    private func applyLayout(for traits: UITraitCollection) {
        let isCompactWidth = traits.horizontalSizeClass == .compact
        NSLayoutConstraint.deactivate(isCompactWidth ? regularConstraints : compactConstraints)
        NSLayoutConstraint.activate(isCompactWidth ? compactConstraints : regularConstraints)
    }
}
