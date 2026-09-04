//
//  DrawerPresentationController.swift
//  Presentation Chrome Manager - owns the dimming backdrop, the
//  drawer's size/position (75% width, left edge), corner rounding,
//  and rotation handling.
//

import UIKit

final class DrawerPresentationController: UIPresentationController {
    
    // Background view shown behind the drawer.
    // It makes the screen darker when the drawer is open.
    private lazy var dimmingView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        // Start invisible and animate it during presentation.
        view.alpha = 0.0
        // Accessibility configuration.
        view.isAccessibilityElement = true
        view.accessibilityLabel = "Dismiss"
        view.accessibilityTraits = .button
        // Tapping the dimmed background dismisses the drawer.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dimmingViewTapped))
        view.addGestureRecognizer(tapGesture)
        
        return view
    }()
    
    // Keep the presenting screen visible in the dimming view.
    // UIKit will not remove the presenting view while the drawer is shown.
    override var shouldRemovePresentersView: Bool {
        return false
    }

    // Defines the final size and position of the drawer.
    // The drawer takes 75% of the screen width and the full screen height.
    // It is positioned starting from the left side of the screen.
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView else {
            return .zero
        }
        let drawerWidth = containerView.bounds.width * 0.75
        return CGRect(x: 0, y: 0, width: drawerWidth, height: containerView.bounds.height)
    }
    
    // Called just before the drawer presentation transition starts.
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        // Make sure the container view exists.
        guard let containerView else {
            return
        }
        // Make the dimming view cover the complete container.
        dimmingView.frame = containerView.bounds
        // Place it behind the drawer.
        containerView.insertSubview(dimmingView, at: 0)
        // Synchronize dimming animation with the presentation transition.
        presentedViewController.transitionCoordinator?.animate { [weak self] _ in
            self?.dimmingView.alpha = 1.0
        }
    }
    
    // Called just before the drawer dismissal transition starts.
    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        
        // Synchronize the dimming fade-out
        // with the drawer dismissal animation.
        presentedViewController.transitionCoordinator?.animate { [weak self] _ in
            self?.dimmingView.alpha = 0.0
        }
    }
    
    // Called when the container view is about to update its layout.
    // This is useful when the screen size changes, such as during rotation.
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()

        guard let containerView else {
            return
        }
        // Keep the dimming view covering the full container.
        dimmingView.frame = containerView.bounds
        // Update the drawer frame when the container size changes.
        presentedView?.frame = frameOfPresentedViewInContainerView
        presentedView?.layer.cornerRadius = 12
        presentedView?.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        presentedView?.clipsToBounds = true
    }

    @objc private func dimmingViewTapped() {
        presentedViewController.dismiss(animated: true)
    }
}
