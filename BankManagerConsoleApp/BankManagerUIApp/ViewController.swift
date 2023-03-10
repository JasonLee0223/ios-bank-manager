//
//  ViewController.swift
//  BankManagerUIApp
//
//  Created by Jason on 2023/03/10.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var mainView = MainView(frame: view.frame)
    private lazy var subView = SubView(frame: view.frame)

    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        
        
    }
    
    private func configureLayout() {
        self.view.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            mainView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.15)
        ])
        
        self.view.addSubview(subView)
        subView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subView.topAnchor.constraint(equalTo: self.mainView.safeAreaLayoutGuide.bottomAnchor),
            subView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            subView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            subView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

