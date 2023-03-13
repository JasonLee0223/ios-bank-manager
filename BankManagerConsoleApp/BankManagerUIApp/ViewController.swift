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
        mainView.delegate = self
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

extension ViewController: SendCustomerInfoDelegate {
    func sendCustomerInfo() {
        var customQueue = UIManager().touchEventAboutAddTenCustomer()
        
        (1...CustomerCount.minimum).forEach { index in
            guard let currentCustomer = customQueue.dequeue() else {
                return
            }

            let _: UILabel = {
                let customerInfoLabel = UILabel()
                customerInfoLabel.text = "\(currentCustomer.waitingNumber) - \(currentCustomer.workType)"
                customerInfoLabel.textAlignment = .center
                customerInfoLabel.font = .systemFont(ofSize: 20, weight: .regular)

                if currentCustomer.workType == WorkType.loan {
                    customerInfoLabel.textColor = .systemPurple
                    subView.workingStackView.addArrangedSubview(customerInfoLabel)
                } else {
                    subView.waitingStackView.addArrangedSubview(customerInfoLabel)
                }
                return customerInfoLabel
            }()
        }
    }
}
