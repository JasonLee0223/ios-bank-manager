//
//  BankManager.swift
//  Created by yagom.
//  Copyright © yagom academy. All rights reserved.
//

import Foundation

struct BankManager {
    static func startProcess() {
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
    
    private static func beginWork() {
        let tellers = assignTellers()
        
        let totalCustomCount = Int.random(in: Requirement.CustomerCount.minimum...Requirement.CustomerCount.maxmimum)
        let totalSpend = calculate(spend: totalCustomCount)
        
        for _ in Requirement.CustomerCount.defaultCustomer...totalCustomCount {
            //TODO: - async process
        }

        OutputMessage.todayWorkDeadline(customer: totalCustomCount, leadTime: totalSpend)
    }
    
    private static func calculate(spend toalCount: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.roundingMode = .halfUp
        numberFormatter.maximumSignificantDigits = 4
        
        let totalLeadTime = Requirement.LeadTime.deposit * Double(toalCount)
        
        guard let totalSpend = numberFormatter.string(for: totalLeadTime) else {
            return Errors.failOfFormatToString.localizedDescription
        }
        
        return totalSpend
    }
    
    private static func assignTellers() -> [Teller] {
        let workTypeList = [Requirement.WorkType.deposit, Requirement.WorkType.deposit, Requirement.WorkType.loan].shuffled()
        var tellers = [Teller]()
        
        for index in 0...2 {
            let workType = workTypeList[index]
            tellers.append(Teller(identifier: workType.rawValue))
        }
        return tellers
    }
    
}
