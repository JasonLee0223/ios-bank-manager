//
//  SendCustomerInfoDelegate.swift
//  BankManagerConsoleApp
//
//  Created by Jason on 2023/03/13.
//

import Foundation

protocol SendCustomerInfoDelegate: AnyObject {
    func sendCustomersInfo() -> [Customer]
    func makeCustomerLabel(customers: [Customer])
    
    func startRepeatTimer()
    
    func drawinigWorkingLabel(of customers: [Customer])
    func removeWaitingCustomerLabel(of customer: Customer) -> Bool
}
