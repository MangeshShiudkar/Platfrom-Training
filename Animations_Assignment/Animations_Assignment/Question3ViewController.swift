//
//  Question3ViewController.swift
//  Animations_Assignment
//
//  Created by Mangesh Shiudkar on 09/09/26.
//

import UIKit

class Question3ViewController: UIViewController {
    // View which will move around inside the container
    private let animationView = UIView()
    // UIViewPropertyAnimator used to control the animation
    private var animator: UIViewPropertyAnimator?
    // Container which defines the animation area
    private let containerView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupContainerView()
        setupAnimationView()
        setupButtons()
    }
    
    // Setup container where the animation will be performed
    private func setupContainerView() {
        containerView.backgroundColor = .systemGray5
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            containerView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
    }
    
    // Setup the view which will be animated
    private func setupAnimationView() {
        animationView.backgroundColor = .systemBrown
        animationView.layer.cornerRadius = 8
        animationView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        containerView.addSubview(animationView)
    
    }
    
    private func setupButtons() {
        // Created buttons to control the animation
        let start = createButton("Start")
        let pause = createButton("Pause")
        let resume = createButton("Resume")
        let reverse = createButton("Reverse")
        
        // Added actions to each button
        start.addTarget(self, action: #selector(startAnimation), for: .touchUpInside)
        pause.addTarget(self, action: #selector(pauseAnimation), for: .touchUpInside)
        resume.addTarget(self, action: #selector(resumeAnimation), for: .touchUpInside)
        reverse.addTarget(self, action: #selector(reverseAnimation), for: .touchUpInside)
        
        // Created stack views to arrange buttons in two columns
        let mainStackView = createStackView(.horizontal)
        let leftStackView = createStackView(.vertical)
        let rightStackView = createStackView(.vertical)
        
        // Added Start and Pause buttons in the left column
        leftStackView.addArrangedSubview(start)
        leftStackView.addArrangedSubview(pause)
        
        // Added Resume and Reverse buttons in the right column
        rightStackView.addArrangedSubview(resume)
        rightStackView.addArrangedSubview(reverse)
        
        // Added both columns inside the main horizontal stack view
        mainStackView.addArrangedSubview(leftStackView)
        mainStackView.addArrangedSubview(rightStackView)
        
        view.addSubview(mainStackView)
        
        // Set the position of the button stack view
        NSLayoutConstraint.activate([
            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40)
        ])
    }
    
    // Create and return a reusable button with the given title
    private func createButton(_ title: String) -> UIButton{
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }
    
    // Create and return a stack view with the given axis
    private func createStackView(_ axis: NSLayoutConstraint.Axis) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = axis
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    // Create and start the animation around all four corners of the container
    @objc private func startAnimation() {
        guard animator == nil else {
            return
        }
        let viewSize = animationView.frame.size
        let topLeft = CGPoint(x: viewSize.width/2, y: viewSize.height/2)
        let topRight = CGPoint(x: containerView.bounds.width - viewSize.width/2, y: viewSize.height/2)
        let bottomRight = CGPoint(x: containerView.bounds.width - viewSize.width/2, y: containerView.bounds.height - viewSize.height/2)
        let bottomLeft = CGPoint(x: viewSize.width/2, y: containerView.bounds.height - viewSize.height/2)
        
        animator = UIViewPropertyAnimator(duration: 6.0, curve: .linear)
        animator?.addAnimations {
            UIView.animateKeyframes(withDuration: 6.0, delay: 0, options: []) {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.25) {
                    self.animationView.center = topRight
                    self.animationView.backgroundColor = .systemRed
                }
                
                UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25) {
                    self.animationView.center = bottomRight
                    self.animationView.backgroundColor = .systemMint
                }
                
                UIView.addKeyframe(withRelativeStartTime: 0.50, relativeDuration: 0.25) {
                    self.animationView.center = bottomLeft
                    self.animationView.backgroundColor = .systemTeal
                }
                
                UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25) {
                    self.animationView.center = topLeft
                    self.animationView.backgroundColor = .systemBrown
                }
            }
        }
        animator?.startAnimation()
        animator?.addCompletion{_ in
            self.animator = nil
        }
    }
    
    // Pause the currently running animation
    @objc private func pauseAnimation() {
        guard let animator = animator else {
            return
        }
        if animator.isRunning {
            animator.pauseAnimation()
        }
    }
    
    // Resume the animation from its paused position
    @objc private func resumeAnimation() {
        guard let animator = animator else {
            return
        }
        animator.continueAnimation( withTimingParameters: nil, durationFactor: 1.0)
    }
    
    // Reverse the direction of the current animation
    @objc private func reverseAnimation() {
        guard let animator = animator else {
            return
        }
        animator.isReversed.toggle()
        animator.startAnimation()
    }
}
