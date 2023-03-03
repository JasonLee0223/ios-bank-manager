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
        let totalCustomCount = makeRandomCustomCount()
        var depositCustomCount = 0
        var loanCustomCount = 0
        
        let work = DispatchWorkItem {
            for customNumber in Requirement.CustomerCount.defaultCustomer...totalCustomCount {
                let order = customNumber % tellers.count
                dispatchWorkQueue(teller: tellers[order], customNumber: customNumber)
                
                switch WorkType(rawValue: tellers[order].identifier) {
                case .deposit:
                    depositCustomCount += 1
                case .loan:
                    loanCustomCount += 1
                case .none:
                    print("Recognizer WorkType Error")
                }
            }
        }
        DispatchQueue.global().asyncAndWait(execute: work)
        
        let totalSpend = calculateToLeadTimeBetween(depositCustomCount, and: loanCustomCount)
        OutputMessage.todayWorkDeadline(customer: totalCustomCount, leadTime: totalSpend)
    }
}

//MARK: - Side Product
extension BankManager {
    private static func calculateToLeadTimeBetween(_ depositCustomCount: Int, and loanCustomCount: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.roundingMode = .halfUp
        numberFormatter.maximumSignificantDigits = 4
        
        let totalLeadTime = Requirement.LeadTime.deposit * Double(depositCustomCount) + Requirement.LeadTime.loan * Double(loanCustomCount)
        
        guard let totalSpend = numberFormatter.string(for: totalLeadTime) else {
            return Errors.failOfFormatToString.localizedDescription
        }
        
        return totalSpend
    }
    
    private static func assignTellers() -> [Teller] {
        let workTypeList = [WorkType.deposit, WorkType.deposit, WorkType.loan].shuffled()
        var tellers = [Teller]()
        
        for index in 0...2 {
            let workType = workTypeList[index]
            tellers.append(Teller(identifier: workType.rawValue))
        }
        return tellers
    }
    
    private static func determineIdentifier(work type: String) -> String {
        switch WorkType(rawValue: type) {
        case .loan:
            return WorkType.loan.description
        case .deposit:
            return WorkType.deposit.description
        default:
            return "WorkType Error"
        }
    }
    
    private static func makeRandomCustomCount() -> Int {
        return Int.random(in: Requirement.CustomerCount.minimum...Requirement.CustomerCount.maxmimum)
    }
}

//MARK: - DispatchQueue Method
extension BankManager {
    private static func dispatchWorkQueue(teller: Teller, customNumber: Int) {
        let workQueue = DispatchQueue(label: "workQueue", attributes: .concurrent)
        let workGroup = DispatchGroup()
        let depositSemaphore = DispatchSemaphore(value: 2)
        let loanSemaphore = DispatchSemaphore(value: 1)
        
        workGroup.enter()
        switch WorkType(rawValue: teller.identifier) {
        case .deposit:
            workQueue.async {
                depositSemaphore.wait()
                asyncProcess(customNumber, teller)
                depositSemaphore.signal()
            }
        case .loan:
            workQueue.sync {
                loanSemaphore.wait()
                asyncProcess(customNumber, teller)
                loanSemaphore.signal()
            }
        case .none:
            print("WorkType Error")
        }
        workGroup.leave()
    }
    
    private static func asyncProcess(_ customNumber: Int, _ teller: Teller) {
        let bankProduct = determineIdentifier(work: teller.identifier)
        
        OutputMessage.work(start: customNumber, type: bankProduct)

        teller.working(responsibility: bankProduct, at: customNumber)

        guard let orderNumber = teller.finishing() else {
            return
        }

        OutputMessage.work(finish: orderNumber, type: bankProduct)
    }
}
