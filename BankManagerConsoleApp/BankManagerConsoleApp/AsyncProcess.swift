//
//  AsyncProcess.swift
//  BankManagerConsoleApp
//
//  Created by Jason on 2023/03/07.
//

import Foundation

class AsyncProcess {
    
    //MARK: - Private Property
    private var customerQueue = Queue<WorkType>()
    private var depositQueue = DispatchQueue(label: "depositQueue", attributes: .concurrent)
    private var loanQueue = DispatchQueue(label: "loanQueue", attributes: .concurrent)
    private let workGroup = DispatchGroup()
    
    private let depositSemaphore = DispatchSemaphore(value: 2)
    private let loanSemaphore = DispatchSemaphore(value: 1)
    
    //MARK: - ex. 고객이 은행이 방문하여 어떤 업무를 볼 지 선택한다.
    func customerProcess() {
        DispatchQueue.global().async {
            self.visit(completion: self.isMakeCustomer)
        }
    }
    
    func isMakeCustomer() -> Bool {
        let allBankWorkType = [WorkType.deposit, WorkType.loan]
        
        if let customerWishTask = allBankWorkType.shuffled().first {
            self.customerQueue.euqueue(customerWishTask)
        }
        return !customerQueue.isEmpty
    }
    
    //MARK: - ex. 은행원이 업무를 모두 마치면 Bool값으로 알려준다.
    func tellerProcess(teller: Teller, _ customerNumber: Int) -> Bool {
        let tellerWorkType = teller.identifier
        
        switch tellerWorkType {
        case .deposit:
            depositSemaphore.wait()
            
            let depositWorkItem = workProcess(teller: teller, customerNumber)
            depositQueue.async(group: workGroup, execute: depositWorkItem)
            
            print(customerQueue.count)
            
            depositSemaphore.signal()
        case .loan:
            loanSemaphore.wait()
            
            let loanWorkItem = workProcess(teller: teller, customerNumber)
            loanQueue.async(group: workGroup, execute: loanWorkItem)
            
            loanSemaphore.signal()
        }
        workGroup.wait()
        return teller.customerQueue.isEmpty
    }
    
    private func workProcess(teller: Teller, _ customerNumber: Int) -> DispatchWorkItem {
        let depositWorkItem = DispatchWorkItem {
            OutputMessage.work(start: customerNumber, type: teller.identifier)
            
            teller.working(responsibility: teller.identifier)
            if let finish = teller.finishing() {
                OutputMessage.work(finish: customerNumber, type: finish)
            }
        }
        return depositWorkItem
    }
    
    private func visit(completion: @escaping () -> Bool) {
        if !completion() {
            print("고객이 없습니다...!!")
        }
    }
    
    private func tellerWorkCompletion(_ completion: @escaping () -> ()) {
        completion()
    }
}
