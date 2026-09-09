//
//  Question2ViewController.swift
//  Animations_Assignment
//
//  Created by Mangesh Shiudkar on 09/09/26.
//

import UIKit

class Question2ViewController: UIViewController {
    // Ball view which will perform the bounce animation
    let ballView = UIView()
    // Button to start the bounce animation
    let bounceButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupBallView()
        setupButtonView()
    }
    
    // Ball view UI setup
    private func setupBallView() {
        ballView.backgroundColor = .systemOrange
        ballView.frame = CGRect(x: 20, y: 300, width: 40, height: 40)
        ballView.layer.cornerRadius = 20
        view.addSubview(ballView)
    }
    
    // Animate button UI setup
    private func setupButtonView() {
        bounceButton.setTitle("Animate", for: .normal)
        bounceButton.setTitleColor(.white, for: .normal)
        bounceButton.backgroundColor = .systemBlue
        bounceButton.titleLabel?.font = UIFont.systemFont(ofSize: 18,weight: .semibold)
        bounceButton.layer.cornerRadius = 12
        bounceButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bounceButton)
        
        // Button position and size
        NSLayoutConstraint.activate([
            bounceButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            bounceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bounceButton.widthAnchor.constraint(equalToConstant: 100),
            bounceButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // Start animation when button is tapped
        bounceButton.addTarget(self, action: #selector(animateButtonTapped), for: .touchUpInside)
    }
    
    @objc private func animateButtonTapped() {
        // Create bounce animation
        let animate = curvePathAnimation()
        // Add animation to the ball layer
        ballView.layer.add(animate, forKey: "bounceAnimation")
    }
    
    private func curvePathAnimation() -> CAKeyframeAnimation {
        // Create keyframe animation for ball position
        let animation = CAKeyframeAnimation(keyPath: "position")
        // Create path for the ball movement
        let path = UIBezierPath()
        // Get the original position of the ball
        let startPosition = CGPoint(x: ballView.center.x, y: ballView.center.y)
        path.move(to: startPosition)
        
        // First and highest bounce
        path.addQuadCurve(
            to: CGPoint(x: startPosition.x + 90, y: startPosition.y),
            controlPoint: CGPoint(x: startPosition.x + 45, y: startPosition.y - 200)
        )
        // Second bounce with reduced height
        path.addQuadCurve(
            to: CGPoint(x: startPosition.x + 170, y: startPosition.y),
            controlPoint: CGPoint(x: startPosition.x + 130, y: startPosition.y - 140)
        )
        // Third bounce with smaller height
        path.addQuadCurve(
            to: CGPoint(x: startPosition.x + 240, y: startPosition.y),
            controlPoint: CGPoint(x: startPosition.x + 205, y: startPosition.y - 85)
        )
        // Final and smallest bounce
        path.addQuadCurve(
            to: CGPoint(x: startPosition.x + 300, y: startPosition.y),
            controlPoint: CGPoint(x: startPosition.x + 270, y: startPosition.y - 40)
        )
        // Move the ball back to its original position
        path.addLine(to: startPosition)
        animation.path = path.cgPath
        animation.duration = 3.0
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        return animation
    }
}
