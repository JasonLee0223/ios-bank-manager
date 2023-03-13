//
//  UIManager.swift
//  BankManagerConsoleApp
//
//  Created by Jason on 2023/03/10.
//

import Foundation

struct UIManager {
    let generator = Generator()
    let asyncProcess = AsyncProcess()
    
    func touchEventAboutAddTenCustomer() -> Queue<Customer> {
        return asyncProcess.makeCustomerQueue()
    }
    
    func touchEventAboutReset() {
        
    }
}
