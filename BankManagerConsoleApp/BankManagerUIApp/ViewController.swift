//
//  ViewController.swift
//  BankManagerUIApp
//
//  Created by Jason on 2023/03/10.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Private Property
    private lazy var mainView = MainView(frame: view.frame)
    private lazy var subView = SubView(frame: view.frame)
    private var asyncManager = AsyncProcess()
    
    private let myGroup = DispatchGroup()
    
    private var timerCounting: Bool = false
    private let repeatingSecoondsTimer = ScheduleManager()
    private var time: Int = 0
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        mainView.mainViewdelegate = self
    }
}

//MARK: - Configure Of Layout
extension ViewController {
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
    
    func makeCustomerLabel(customers: [Customer], completion: @escaping (Bool) -> Void) {
        DispatchQueue.main.async {
            customers.forEach { currentCustomer in
                let customerInfoLabel : UILabel = {
                    let customerInfoLabel = UILabel()
                    customerInfoLabel.text = "\(currentCustomer.waitingNumber) - \(currentCustomer.workType)"
                    customerInfoLabel.textAlignment = .center
                    customerInfoLabel.font = .systemFont(ofSize: 20, weight: .regular)
                    
                    if currentCustomer.workType == WorkType.loan {
                        customerInfoLabel.textColor = .systemPurple
                    }
                    return customerInfoLabel
                }()
                
                self.subView.waitingStackView.addArrangedSubview(customerInfoLabel)
            }
            completion(true)
        }
    }
    
    func drawinigWorkingLabel(customers: [Customer]) {
        asyncManager.dequeue(in: customers) { _ in
            DispatchQueue.main.async { [self] in
                if let customerLabel = subView.waitingStackView.subviews.first {
                    subView.workingStackView.addArrangedSubview(customerLabel)
                }
            }
        }
    }
    
    func startRepeatTimer(of customers: [Customer]) {
        if let customerLabel = subView.waitingStackView.subviews.first {
            subView.waitingStackView.removeArrangedSubview(customerLabel)
            subView.waitingStackView.removeFromSuperview()
        }
        
        asyncManager.calculateAllSpendWorkTime(of: customers) { allSpendTime in
            self.repeatingSecoondsTimer.start(durationSeconds: allSpendTime) { [self] in
                DispatchQueue.main.async { [self] in
                    time += 1
                    let calculatedTime = secondsToHoursMinutesSeconds(seconds: time)
                    let makedOfficeHourSentence = makeTimeString(hours: calculatedTime.0, minutes: calculatedTime.1, seconds: calculatedTime.2)
                    mainView.officeHours.text = "업무시간 - " + makedOfficeHourSentence
                }
            }
        }
    }
}


extension ViewController {
    func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int) {
        return ((seconds / 3600), ((seconds % 3600) / 60), ((seconds % 3600) % 60))
    }
    
    func makeTimeString(hours: Int, minutes: Int, seconds: Int) -> String {
        var timeString = ""
        
        timeString += String(format: "0%2d", hours)
        timeString += " : "
        timeString += String(format: "0%2d", minutes)
        timeString += " : "
        timeString += String(format: "0%2d", seconds)
        return timeString
    }
}
