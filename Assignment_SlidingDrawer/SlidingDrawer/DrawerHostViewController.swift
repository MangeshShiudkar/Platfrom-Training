//
//  DrawerHostViewController.swift
//  Integration Delegate - vends the Animator, Presentation Controller,
//  and Interaction Controller to UIKit. Also supports opening the
//  drawer via a second, independent entry point: a left screen-edge
//  swipe.
//
//  The button and layout below are provided and working - that part
//  isn't being tested. Your job is the TODOs: wiring this screen up
//  to actually use your other classes.
//

import UIKit

final class DrawerHostViewController: UIViewController, UIViewControllerTransitioningDelegate, UIGestureRecognizerDelegate {

    private var activeInteractionController: DrawerPanInteractionController?
    private var isDrawerPresented = false

    private let openButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Open Drawer", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let hintLabel: UILabel = {
        let label = UILabel()
        label.text = "Or swipe in from the left edge"
        label.font = .systemFont(ofSize: 13)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Host"

        view.addSubview(openButton)
        view.addSubview(hintLabel)
        NSLayoutConstraint.activate([
            openButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            openButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            openButton.widthAnchor.constraint(equalToConstant: 220),
            openButton.heightAnchor.constraint(equalToConstant: 50),

            hintLabel.topAnchor.constraint(equalTo: openButton.bottomAnchor, constant: 12),
            hintLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        openButton.addTarget(self, action: #selector(openDrawerTapped), for: .touchUpInside)

        // Allows the drawer to be opened with a swipe from the left screen edge.
        let edgePanGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleEdgeSwipe(_:)))
        edgePanGesture.edges = .left
        edgePanGesture.delegate = self
        view.addGestureRecognizer(edgePanGesture)
    }
    
    // Opens the drawer when the Open Drawer button is tapped.
    @objc private func openDrawerTapped() {
        presentDrawer()
    }
    
    // Opens the drawer only when the left edge swipe begins and no drawer is already open.
    @objc private func handleEdgeSwipe(_ gesture: UIScreenEdgePanGestureRecognizer) {
        guard gesture.state == .began, !isDrawerPresented else {
            return
        }
        presentDrawer()
    }
    
    // Creates and presents the drawer with custom presentation and interaction handling.
    private func presentDrawer() {
        guard !isDrawerPresented else {
            return
        }
        let drawerVC = DrawerContentViewController()
        
        // Uses the custom transition provided by this view controller.
        drawerVC.modalPresentationStyle = .custom
        drawerVC.transitioningDelegate = self
        
        // Attach the pan gesture used for interactive drawer dismissal.
        let interactionController = DrawerPanInteractionController()
        interactionController.attach(to: drawerVC)
        activeInteractionController = interactionController
        isDrawerPresented = true
        present(drawerVC, animated: true)
    }

    // MARK: - UIGestureRecognizerDelegate
    
    // Prevent opening another drawer while it is already presented.
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return !isDrawerPresented
    }

    // MARK: - UIViewControllerTransitioningDelegate
    
    // Provides the custom animator used when presenting the drawer.
    func animationController(forPresented presented: UIViewController, presenting: UIViewController,
                              source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideInDrawerAnimator(transitionType: .present)
    }
    
    // Provides the custom animator used when dismissing the drawer.
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isDrawerPresented = false
        return SlideInDrawerAnimator(transitionType: .dismiss)
    }
    
    // Provides the custom presentation controller for drawer layout and dimming.
    func presentationController(forPresented presented: UIViewController,
                                 presenting: UIViewController?,
                                 source: UIViewController) -> UIPresentationController? {
        return DrawerPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    // Provides the interaction controller only while an interactive pan dismissal is active.
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?{
        if activeInteractionController?.isInteractionInProgress == true {
            return activeInteractionController
        }
        return nil
    }
}
