//
//  BankManager.swift
//  Created by yagom.
//  Copyright © yagom academy. All rights reserved.
//

import Foundation

struct BankManager {
    
    //MARK: - Caller
    
    func startProcess() {
        var isContinue = true
        
        repeat {
            print(OutputMessage.menu)
            
            guard let userInput = readLine() else { return }
            
            guard userInput == WorkList.openBank.rawValue || userInput == WorkList.closeBank.rawValue else {
                print(Errors.invalidUserInput.localizedDescription)
                return
            }
            
            switch WorkList(rawValue: userInput) {
            case .openBank:
                OutputMessage.conform(userInput)
                beginWork()
            case .closeBank:
                OutputMessage.conform(userInput)
                isContinue = false
            default:
                return
            }
        } while isContinue
    }
    
    //MARK: - Callee
    
    private func beginWork() {
        let generator = Generator()
        let tellers = generator.assignTellers()
        let totalCustomCount = generator.randomCustomerCount()
        
        let asyncProcess = AsyncProcess()
        var depositCustomCount = 0
        var loanCustomCount = 0
        var isAllTaskFinish = false
        
        //MARK: - sync
        for customerNumber in CustomerCount.defaultCustomer...totalCustomCount {
            let order = customerNumber % tellers.count

            //MARK: - async customer Queue
            asyncProcess.customerProcess()

            //MARK: - async teller Queue
            let isFinishWork = asyncProcess.tellerProcess(teller: tellers[order], customerNumber)

            switch tellers[order].identifier {
            case .deposit:
                depositCustomCount += 1
            case .loan:
                loanCustomCount += 1
            }
            isAllTaskFinish = isFinishWork
        }
        
        if isAllTaskFinish {
            let totalSpend = calculateToLeadTimeBetween(depositCustomCount, and: loanCustomCount)
            OutputMessage.todayWorkDeadline(customer: totalCustomCount, leadTime: totalSpend)
        }
    }
}

//MARK: - Side Product
extension BankManager {
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
