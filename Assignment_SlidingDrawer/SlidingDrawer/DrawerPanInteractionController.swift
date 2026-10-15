//
//  DrawerPanInteractionController.swift
//  Interactive Gesture Controller - converts a horizontal pan gesture
//  into a dismissal, with a completion threshold and a fast-flick
//  velocity override.
//

import UIKit

final class DrawerPanInteractionController: UIPercentDrivenInteractiveTransition {
    
    // Tracks whether the user is currently performing an interactive dismissal.
    private(set) var isInteractionInProgress = false
    private weak var viewController: UIViewController?
    private var shouldCompleteTransition = false

    // Defines when the drag or flick should complete the drawer dismissal.
    private let completionThreshold: CGFloat = 0.25
    private let flickVelocityThreshold: CGFloat = 800
    
    // Attaches a pan gesture recognizer to the drawer view.
    func attach(to viewController: UIViewController) {
        self.viewController = viewController
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        viewController.view.addGestureRecognizer(panGesture)
    }
    
    // Converts the user's horizontal pan gesture into an interactive dismissal.
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        guard let view = gesture.view else {
            return
        }
        let translationX = gesture.translation(in: view).x
        let velocityX = gesture.velocity(in: view).x
        
        // Adjust the dismissal direction based on the interface layout direction.
        let layoutDirection = UIView.userInterfaceLayoutDirection(
            for: view.semanticContentAttribute
        )
        let horizontalTranslation: CGFloat
        let horizontalVelocity: CGFloat

        switch layoutDirection {
        case .leftToRight:
            // In LTR the drawer dismisses towards the left.
            horizontalTranslation = -translationX
            horizontalVelocity = -velocityX
        case .rightToLeft:
            // In RTL the drawer dismisses towards the right.
            horizontalTranslation = translationX
            horizontalVelocity = velocityX
        default:
            // Default to LTR behavior.
            horizontalTranslation = -translationX
            horizontalVelocity = -velocityX
        }
        // Convert the drag distance into a progress value between 0 and 1.
        let progress = max(0,min(1,horizontalTranslation / view.bounds.width))
        
        // Handle each stage of the user's pan gesture.
        switch gesture.state {
        case .began:
            // Start the interactive dismissal.
            isInteractionInProgress = true
            viewController?.dismiss(animated: true)
            break
        case .changed:
            // Update the transition and decide whether it should finish.
            shouldCompleteTransition = progress > completionThreshold || horizontalVelocity > flickVelocityThreshold
            update(progress)
            break
        case .cancelled:
            // Finish or cancel the transition based on the current progress.
            isInteractionInProgress = false
            if shouldCompleteTransition {
                finish()
            } else{
                cancel()
            }
            break
        case .ended:
            // Complete the dismissal if the drag distance or flick speed is enough.
            isInteractionInProgress = false
            if shouldCompleteTransition || horizontalVelocity > flickVelocityThreshold {
                finish()
            } else {
                cancel()
            }
            break
        default:
            break
        }
    }
}
