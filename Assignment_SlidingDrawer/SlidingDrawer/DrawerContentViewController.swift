//
//  DrawerContentViewController.swift
//  The drawer's content.
//
//  Basic content/layout below is provided so the project runs - build
//  on it however you'd like, that part isn't being tested. The
//  accessibility wiring is your responsibility - use the checklist
//  below.
//
//  [ ] accessibilityViewIsModal = true - which view, and what does it prevent?
//  [ ] A .screenChanged focus notification once the drawer finishes presenting.
//  [ ] A SEPARATE .announcement notification describing the state
//      change itself ("Navigation drawer opened" / "...closed") - not
//      just focus movement. Where does each one belong: on open, on
//      close, or both?
//

import UIKit

final class DrawerContentViewController: UIViewController {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Navigation"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Close", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = .systemGray5
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground

        view.addSubview(titleLabel)
        view.addSubview(closeButton)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            closeButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            closeButton.widthAnchor.constraint(equalToConstant: 100),
            closeButton.heightAnchor.constraint(equalToConstant: 40)
        ])

        // Keep VoiceOver focus inside the drawer while it is presented.
        view.accessibilityViewIsModal = true
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Move VoiceOver focus to the drawer content and announce that the drawer is open.
        UIAccessibility.post(
            notification: .screenChanged,
            argument: titleLabel
        )
        UIAccessibility.post(
            notification: .announcement,
            argument: "Navigation drawer opened"
        )
    }
    
    // Handles closing the drawer and announces the state change after dismissal finishes.
    @objc private func closeButtonTapped() {
        dismiss(animated: true) {
            UIAccessibility.post(
                notification: .announcement,
                argument: "Navigation drawer closed"
            )
        }
    }
}
