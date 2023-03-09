//
//  AsyncProcess.swift
//  BankManagerConsoleApp
//
//  Created by Jason on 2023/03/09.
//

import Foundation

final class AsyncProcess {
    
    //MARK: - Private Property
    private var customerQueue = Queue<Customer>()
    
    //MARK: - Handling Async Process
    func topOfTop(_ tellers: [Teller], _ totalVisitCustomer: Int) {
        let workGroup = DispatchGroup()
        let workQueue = DispatchQueue(label: "workQueue", attributes: .concurrent)
        
        var depositCustomerCount = 0
        var loanCustomerCount = 0
        
        //TODO: - 고객 대기열 생성 - async & enqueue
        makeCustomerQueue(of: totalVisitCustomer)
        
        //TODO: - 업무 대기열 생성 - async & dequeue
        tellers.forEach { teller in
            workQueue.async(group: workGroup) {
                while !self.customerQueue.isEmpty {
                    self.work(start: teller)
                    
                    switch teller.identifier {
                    case .deposit:
                        depositCustomerCount += 1
                    case .loan:
                        loanCustomerCount += 1
                    }
                }
            }
        }
        workGroup.wait()
        
        //TODO: - 업무 완료 메세지 출력
        let totalSpendTime = calculateToLeadTimeBetween(depositCustomerCount, and: loanCustomerCount)
        OutputMessage.todayWorkDeadline(customer: totalVisitCustomer, leadTime: totalSpendTime)
    }
    
    //MARK: - 고객 명단 생성
    private func makeCustomerQueue(of totalCustomerCount: Int) {
        for waitingNumber in CustomerCount.defaultCustomer...totalCustomerCount {
            let randomAssignToCustomerOfWorkType = makeRandomWorkType()
            let customer = Customer(waitingNumber: waitingNumber, workType: randomAssignToCustomerOfWorkType)
            
            customerQueue.euqueue(customer)
        }
    }
    
    private func makeRandomWorkType() -> WorkType {
        let allWorkType = [WorkType.deposit, WorkType.loan].shuffled()
        
        guard let randomAssignToCustomerOfWorkType = allWorkType.first else {
            return .deposit
        }
        return randomAssignToCustomerOfWorkType
    }
    
    //MARK: - 은행원이 대기열을 가져간다.
    private func work(start teller: Teller) {
        let depositSemaphore = DispatchSemaphore(value: 2)
        let loanSemaphore = DispatchSemaphore(value: 1)
        
        switch teller.identifier {
        case .deposit:
            depositSemaphore.wait()
            guard let finishCustomer = customerQueue.dequeue() else {
                return
            }
            teller.spendTime(of: finishCustomer)
            depositSemaphore.signal()
        case .loan:
            loanSemaphore.wait()
            guard let finishCustomer = customerQueue.dequeue() else {
                return
            }
            teller.spendTime(of: finishCustomer)
            loanSemaphore.signal()
        }
    }
    
    //MARK: - 총 소요시간 계산
    private func calculateToLeadTimeBetween(_ depositCustomCount: Int, and loanCustomCount: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.roundingMode = .halfUp
        numberFormatter.maximumSignificantDigits = 4
        
        let totalLeadTime = WorkType.deposit.leadTime * Double(depositCustomCount) + WorkType.loan.leadTime * Double(loanCustomCount)
        
        guard let totalSpend = numberFormatter.string(for: totalLeadTime) else {
            return Errors.failOfFormatToString.localizedDescription
        }
        
        return totalSpend
    }
}
