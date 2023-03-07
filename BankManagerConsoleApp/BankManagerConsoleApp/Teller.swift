//
//  Teller.swift
//  BankManagerConsoleApp
//
//  Created by Jason on 2023/02/23.
//

import Foundation

final class Teller: Workable {
    private(set) var customerQueue = Queue<WorkType>()
    var identifier: WorkType
    
    init(identifier: WorkType) {
        self.identifier = identifier
    }
    
    func working(responsibility: WorkType) {
        customerQueue.euqueue(responsibility)
        spendTime(at: responsibility)
    }
    
    func finishing() -> WorkType? {
        guard let finishCustomNumber = customerQueue.dequeue() else { return nil }
        return finishCustomNumber
    }
    
    private func spendTime(at identifier: WorkType) {
        switch identifier {
        case .deposit:
            Thread.sleep(forTimeInterval: WorkType.deposit.leadTime)
        case .loan:
            Thread.sleep(forTimeInterval: WorkType.loan.leadTime)
        }
    }
}
