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
    private var asyncManager = AsyncProcess()
    
    private var timerCounting: Bool = false
    private var count: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        mainView.mainViewdelegate = self
        
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

//MARK: - MainView Delegate Method
extension ViewController: SendCustomerInfoDelegate {
    
    func sendCustomersInfo() -> [Customer] {
        return asyncManager.makeCustomerQueue()
    }
    
    func makeCustomerLabel(customers: [Customer],
                           completion: @escaping (Customer) -> Void) {
        customers.forEach { currentCustomer in
            let customerInfoLabel : UILabel = {
                let customerInfoLabel = UILabel()
                customerInfoLabel.text = "\(currentCustomer.waitingNumber) - \(currentCustomer.workType)"
                customerInfoLabel.textAlignment = .center
                customerInfoLabel.font = .systemFont(ofSize: 20, weight: .regular)
                
                if currentCustomer.workType == WorkType.loan {
                    customerInfoLabel.textColor = .systemPurple
                }
                
                completion(currentCustomer)
                
                return customerInfoLabel
            }()
            
            DispatchQueue.main.async {
                self.subView.waitingStackView.addArrangedSubview(customerInfoLabel)
            }
        }
    }
    
    func drawinigWorkingLabel(of customer: Customer,
                              completion: @escaping () -> Void) {
        let workingCustomer: UILabel = {
            let workingCustomer = UILabel()
            workingCustomer.text = "\(customer.waitingNumber) - \(customer.workType)"
            workingCustomer.textAlignment = .center
            workingCustomer.font = .systemFont(ofSize: 20, weight: .regular)
            
            return workingCustomer
        }()
        completion()
        
        DispatchQueue.main.async {
            self.subView.workingStackView.addArrangedSubview(workingCustomer)
        }
    }
    
    func removeWaitingCustomerLabel(of customer: Customer) -> Bool {
        
        return true
    }
}
