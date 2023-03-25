//
//  SendCustomerInfoDelegate.swift
//  BankManagerConsoleApp
//
//  Created by Jason on 2023/03/13.
//

import Foundation

protocol SendCustomerInfoDelegate: AnyObject {
    func sendCustomersInfo() -> [Customer]
    func makeCustomerLabel(customers: [Customer], completion: @escaping (Customer) -> Void)
    
    func startRepeatTimer()
    
    func drawinigWorkingLabel(of customer: Customer, completion: @escaping () -> Void)
    func removeWaitingCustomerLabel(of customer: Customer) -> Bool
}
