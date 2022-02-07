//
//  ViewController.swift
//  chatApp
//
//  Created by Maïlys Perez on 07/02/2022.
//

import UIKit

final class HomeViewController: UIViewController {
    
    let segmentedControl: UISegmentedControl = UISegmentedControl(items: ["Chatter 1", "Chatter 2"])
    let chatViewController: ChatViewController = ChatViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedControl.addTarget(self, action: #selector(onSegChange(_:)), for: .valueChanged)
        setupView()
    }
    
    override var canBecomeFirstResponder: Bool {
        return chatViewController.canBecomeFirstResponder
    }
    
    override var inputAccessoryView: UIView? {
        return chatViewController.inputAccessoryView
    }
    
    private func setupView() {
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.selectedSegmentTintColor = .systemPink
        self.view.addSubview(segmentedControl)
        self.addChild(chatViewController)
        self.view.addSubview(chatViewController.view)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        segmentedControl.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20.0).isActive = true
        chatViewController.view.translatesAutoresizingMaskIntoConstraints = false
        chatViewController.view.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 0).isActive = true
        chatViewController.view.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: 0).isActive = true
        chatViewController.view.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        chatViewController.view.topAnchor.constraint(equalTo: self.segmentedControl.bottomAnchor, constant: 20.0).isActive = true
    }
    
    @objc private func onSegChange(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            chatViewController.currentUser = chatViewController.firstUser
            sender.selectedSegmentTintColor = .systemPink
        } else if sender.selectedSegmentIndex == 1 {
            chatViewController.currentUser = chatViewController.secondUser
            sender.selectedSegmentTintColor = .systemBlue
        }
        chatViewController.messagesCollectionView.reloadData()
    }
}

