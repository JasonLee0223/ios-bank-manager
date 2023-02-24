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
            print(OutputMessage.programStart)
            
            guard let userInput = readLine() else {
                return
            }
            
            guard userInput == WorkList.openBank.rawValue || userInput == WorkList.closeBank.rawValue else {
                print(UserInputError.invalidUserInput.localizedDescription)
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
        var teller = Teller(identifier: "Teller1")
        let totalCustomCount = Int.random(in: Requirement.CustomerCount.minimum...Requirement.CustomerCount.maxmimum)
        
        for customNumber in Requirement.CustomerCount.defaultCustomer...totalCustomCount {
            OutputMessage.work(start: customNumber)
            
            teller.working(responsibility: customNumber)
            let finishCustomNumber = teller.finishing()
            
            OutputMessage.work(finish: finishCustomNumber)
        }
        let totalSpend = calculate(spend: totalCustomCount)

        OutputMessage.todayWorkDeadline(customer: totalCustomCount, leadTime: totalSpend)
    }
    
    private static func calculate(spend toalCount: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.roundingMode = .floor
        numberFormatter.maximumSignificantDigits = 4
        
        let totalLeadTime = Requirement.leadTime * Double(toalCount)
        
        guard let totalSpend = numberFormatter.string(for: totalLeadTime) else {
            return FailFormatting.failOfFormatToString.localizedDescription
        }
        
        return totalSpend
    }
}
