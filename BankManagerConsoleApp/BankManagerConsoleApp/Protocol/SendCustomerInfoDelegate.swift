//
//  SendCustomerInfoDelegate.swift
//  BankManagerConsoleApp
//
//  Created by Jason on 2023/03/13.
//

import Foundation

protocol SendCustomerInfoDelegate: AnyObject {
    func sendCustomersInfo() -> [Customer]
    func makeCustomerLabel(customers: [Customer], completion: @escaping (Bool) -> Void)
    func drawinigWorkingLabel(customers: [Customer])
    func startRepeatTimer(of customers: [Customer])
    
    func allClear()
}
