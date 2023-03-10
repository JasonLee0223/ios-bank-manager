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

        asyncProcessor.workStart(tellers, totalVisitCustomer)
    }
}
