//
//  SlideInDrawerAnimator.swift
//  Custom Animator - handles both .present and .dismiss for a
//  left-side drawer.
//
//  This file compiles as-is (placeholder completeTransition call) so
//  the project builds and runs before you've implemented anything -
//  you just won't see the drawer animate yet.
//

import UIKit

final class SlideInDrawerAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    // Defines whether the current animation is presenting
    // or dismissing the drawer.
    enum TransitionType {
        case present
        case dismiss
    }
    
    // Stores the type of transition that should be performed.
    private let transitionType: TransitionType
    // Stores how long the animation should take.
    private let duration: TimeInterval

    init(transitionType: TransitionType, duration: TimeInterval = 0.4) {
        self.transitionType = transitionType
        self.duration = duration
        super.init()
    }
    
    // Returns the duration of the transition animation.
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    // Performs the custom animation for presenting or dismissing the drawer.
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // The container view is the main view where the transition happens.
        let containerView = transitionContext.containerView
        // Make sure both the current and destination view controllers exist.
        guard transitionContext.viewController(forKey: .from) != nil,
            let toViewController = transitionContext.viewController(forKey: .to) else {
            transitionContext.completeTransition(false)
            return
        }
        
        // Select the correct view based on the type of transition.
        let animatingView: UIView?
        switch transitionType {
        case .present:
            animatingView = transitionContext.view(forKey: .to)
        case .dismiss:
            animatingView = transitionContext.view(forKey: .from)
        }
        guard let animatingView else {
            transitionContext.completeTransition(false)
            return
        }
        // Get the final position and size of the destination view.
        let onScreenFrame = transitionContext.finalFrame(
            for: toViewController
        )
        
        // Check the interface layout direction so the drawer works
        // correctly for both left-to-right and right-to-left layouts.
        let layoutDirection = UIView.userInterfaceLayoutDirection(
            for: animatingView.semanticContentAttribute
        )
        // Create a frame for the drawer when it is outside the screen.
        var offScreenFrame = onScreenFrame
        
        switch layoutDirection {
        case .leftToRight:
            // In left-to-right layouts, move the drawer outside
            // the left side of the screen.
            offScreenFrame.origin.x = -onScreenFrame.width
        case .rightToLeft:
            // In right-to-left layouts, move the drawer outside
            // the right side of the screen.
            offScreenFrame.origin.x = onScreenFrame.width
        default:
            offScreenFrame.origin.x = -onScreenFrame.width
        }
        
        // These frames define where the animation starts
        // and where it should end.
        let initialFrame: CGRect
        let targetFrame: CGRect

        switch transitionType {
        case .present:
            initialFrame = offScreenFrame
            targetFrame = onScreenFrame
            containerView.addSubview(animatingView)
        case .dismiss:
            initialFrame = animatingView.frame
            targetFrame = offScreenFrame
        }
        
        animatingView.frame = initialFrame
        
        // When Reduce Motion accessibility setting is enabled skip the animation
        if UIAccessibility.isReduceMotionEnabled {
            animatingView.frame = targetFrame
            let completed = !transitionContext.transitionWasCancelled
            if transitionType == .dismiss && completed {
                animatingView.removeFromSuperview()
            }
            transitionContext.completeTransition(completed)
            return
        }
        
        // Animate the drawer to its target position using a spring animation.
        UIView.animate(
            withDuration: transitionDuration( using: transitionContext),
            delay: 0,
            usingSpringWithDamping: 0.9,
            initialSpringVelocity: 0.3,
            options: [.curveEaseInOut],
            animations: {
                animatingView.frame = targetFrame
            },
            completion: { [weak self] _ in
                let completed = !transitionContext.transitionWasCancelled
                
                if self?.transitionType == .dismiss && completed {
                    animatingView.removeFromSuperview()
                }
                transitionContext.completeTransition(completed)
            }
        )
    }
}
