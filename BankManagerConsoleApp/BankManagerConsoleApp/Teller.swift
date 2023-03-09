//
//  Teller.swift
//  BankManagerConsoleApp
//
//  Created by Jason on 2023/02/23.
//

import Foundation

struct Teller: Workable {
    var identifier: WorkType
    
    init(identifier: WorkType) {
        self.identifier = identifier
    }
    
    func spendTime(of customer: Customer) {
        switch identifier {
        case .deposit:
            OutputMessage.presentRequestStarted(of: customer)
            Thread.sleep(forTimeInterval: WorkType.deposit.leadTime)
            OutputMessage.presentResponseFinish(of: customer)
        case .loan:
            OutputMessage.presentRequestStarted(of: customer)
            Thread.sleep(forTimeInterval: WorkType.loan.leadTime)
            OutputMessage.presentResponseFinish(of: customer)
        }
    }
}
