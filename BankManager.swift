//
//  BankManager.swift
//  Created by yagom.
//  Copyright © yagom academy. All rights reserved.
//

import Foundation

struct BankManager: Receivable {
    
    //MARK: - Caller
    func startProcess() {
        let inputStatus = receiveUserInput
        
        switch WorkList(rawValue: inputStatus) {
        case .openBank:
            OutputMessage.conform(inputStatus)
            openBank()
            return startProcess()
        case .closeBank:
            OutputMessage.conform(inputStatus)
            break
        default:
            return
        }
    }
    
    //MARK: - Callee
    private func openBank() {
        let generator = Generator()
        let asyncProcessor = AsyncProcess()
        let tellers = generator.assignTellers()
        let totalVisitCustomer = generator.randomCustomerCount()

        asyncProcessor.topOfTop(tellers, totalVisitCustomer)
        
        //TODO: - 업무 완료 메세지 출력
        print("끝남")
    }
    
    private func calculate(spend toalCount: Int) -> String {
        //        let numberFormatter = NumberFormatter()
        //        numberFormatter.roundingMode = .halfUp
        //        numberFormatter.maximumSignificantDigits = 4
        //
        //        let totalLeadTime = Requirement.leadTime * Double(toalCount)
        //
        //        guard let totalSpend = numberFormatter.string(for: totalLeadTime) else {
        //            return Errors.failOfFormatToString.localizedDescription
        //        }
        //
        //        return totalSpend
        return ""
    }
}
