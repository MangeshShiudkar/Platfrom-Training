//
//  Question1ViewController.swift
//  Animations_Assignment
//
//  Created by Mangesh Shiudkar on 09/09/26.
//

import UIKit

class Question1ViewController: UIViewController {
    // Square view which we are going to animate
    let squareView = UIView()
    // Button to start the animation
    let animateButton = UIButton(type: .system)
    // Used to check whether square is moved or in original position
    var isMoved = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupSquareView()
        setupAnimateButton()
    }
    // Constraints which we will update during animation
    var leadingConstraint: NSLayoutConstraint!
    var topConstraint: NSLayoutConstraint!
    var widthConstraint: NSLayoutConstraint!
    var heightConstraint: NSLayoutConstraint!
    
    private func setupSquareView() {
        // Square view UI setup
        squareView.backgroundColor = .systemMint
        squareView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(squareView)
        
        // Initial position and size of square view
        leadingConstraint = squareView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        topConstraint = squareView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 400)
        heightConstraint = squareView.heightAnchor.constraint(equalToConstant: 100)
        widthConstraint = squareView.widthAnchor.constraint(equalToConstant: 100)
        
        NSLayoutConstraint.activate([
            leadingConstraint,
            topConstraint,
            heightConstraint,
            widthConstraint
        ])
    }
    
    private func setupAnimateButton() {
        // Animate button UI setup
        animateButton.setTitle("Animate", for: .normal)
        animateButton.setTitleColor(.white, for: .normal)
        animateButton.backgroundColor = .systemBlue
        animateButton.titleLabel?.font = UIFont.systemFont(ofSize: 18,weight: .semibold)
        animateButton.layer.cornerRadius = 12
        animateButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animateButton)
        
        // Button position and size
        NSLayoutConstraint.activate([
            animateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            animateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animateButton.widthAnchor.constraint(equalToConstant: 100),
            animateButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // Calling animation method when button is tapped
        animateButton.addTarget(self, action: #selector(animateButtonTapped), for: .touchUpInside)
    }
    
    @objc private func animateButtonTapped() {
        // Change the state on every button tap
        isMoved = !isMoved
        UIView.animate(withDuration: 1.0, delay: 0.2, options: [.curveEaseInOut], animations: {
            if self.isMoved {
                // Move square to new position and increase its size
                self.leadingConstraint.constant = 150
                self.topConstraint.constant = 100
                self.widthConstraint.constant = 200
                self.heightConstraint.constant = 200
            }else {
                // Move square back to its original position and size
                self.leadingConstraint.constant = 20
                self.topConstraint.constant = 400
                self.widthConstraint.constant = 100
                self.heightConstraint.constant = 100
            }
            // Update layout so constraint changes are animated
            self.view.layoutIfNeeded()
        })
    }
}
