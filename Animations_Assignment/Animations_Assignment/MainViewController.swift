//
//  ViewController.swift
//  Animations_Assignment
//
//  Created by Mangesh Shiudkar on 09/09/26.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupButtons()
    }
    private func setupButtons() {
        let button1 = createButton("Move and Resize")
        let button2 = createButton("Bouncing Ball")
        let button3 = createButton("Property Animator")
        button1.addTarget(self, action: #selector(gotoQuestion1), for: .touchUpInside)
        button2.addTarget(self, action: #selector(gotoQuestion2), for: .touchUpInside)
        button3.addTarget(self, action: #selector(gotoQuestion3), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [button1,button2,button3])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
    
    private func createButton(_ title: String) -> UIButton{
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }
    
    @objc private func gotoQuestion1() {
        navigationController?.pushViewController(Question1ViewController(), animated: true)
    }
    
    @objc private func gotoQuestion2() {
        navigationController?.pushViewController(Question2ViewController(), animated: true)
    }
    
    @objc private func gotoQuestion3() {
        navigationController?.pushViewController(Question3ViewController(), animated: true)
    }

}

