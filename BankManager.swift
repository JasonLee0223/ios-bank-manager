//
//  BankManager.swift
//  Created by yagom.
//  Copyright © yagom academy. All rights reserved.
//

import Foundation

struct BankManager: Receivable {
    func startProcess() {
        let inputStatus = receiveUserInput
        
        OutputMessage.startMessage()
        
        switch WorkList(rawValue: inputStatus) {
        case .openBank:
            OutputMessage.conform(inputStatus)
            beginWork()
            return startProcess()
        case .closeBank:
            OutputMessage.conform(inputStatus)
            break
        default:
            return
        }
    }
    
    private func beginWork() {
        let teller = Teller()
        teller.identifier = "Teller1"
        let totalCustomCount = Int.random(in: Requirement.CustomerCount.minimum...Requirement.CustomerCount.maxmimum)
        let totalSpend = calculate(spend: totalCustomCount)

        for customNumber in Requirement.CustomerCount.defaultCustomer...totalCustomCount {
            OutputMessage.work(start: customNumber)
            
            teller.working(responsibility: customNumber)
            Thread.sleep(forTimeInterval: Requirement.leadTime)
            
            guard let finishCustomNumber = teller.finishing() else { return }
            
            OutputMessage.work(finish: finishCustomNumber)
        }

        OutputMessage.todayWorkDeadline(customer: totalCustomCount, leadTime: totalSpend)
    }
    
    private func calculate(spend toalCount: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.roundingMode = .halfUp
        numberFormatter.maximumSignificantDigits = 4
        
        let totalLeadTime = Requirement.leadTime * Double(toalCount)
        
        guard let totalSpend = numberFormatter.string(for: totalLeadTime) else {
            return Errors.failOfFormatToString.localizedDescription
        }
        
        return totalSpend
    }
}
