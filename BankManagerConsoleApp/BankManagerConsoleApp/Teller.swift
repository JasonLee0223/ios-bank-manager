//
//  Teller.swift
//  BankManagerConsoleApp
//
//  Created by Jason on 2023/02/23.
//

import Foundation

final class Teller: Workable {
    var identifier: String
    
    init(identifier: String) {
        self.identifier = identifier
    }
    private(set) var customerQueue = Queue<Int>()
    
    func working(responsibility: String, at orderNumber: Int) {
        customerQueue.euqueue(orderNumber)
        work(at: responsibility)
    }
    
    func finishing() -> Int? {
        guard let finishCustomNumber = customerQueue.dequeue() else { return nil }
        return finishCustomNumber
    }
    
    private func work(at identifier: String) {
        switch WorkType(rawValue: identifier) {
        case .loan:
            Thread.sleep(forTimeInterval: Requirement.LeadTime.loan)
        case .deposit:
            Thread.sleep(forTimeInterval: Requirement.LeadTime.deposit)
        case .none:
            print("sleep Error")
        }
    }
}
