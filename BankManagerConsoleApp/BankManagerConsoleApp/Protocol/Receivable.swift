//
//  Receivable.swift
//  BankManagerConsoleApp
//
//  Created by Jason on 2023/03/09.
//

import Foundation

protocol Receivable {
    var receiveUserInput: String { get }
}

extension Receivable {
    var receiveUserInput: String {
        guard let userInput = readLine() else {
            return Errors.notReceive.localizedDescription
        }
        
        guard userInput == WorkList.openBank.rawValue || userInput == WorkList.closeBank.rawValue else {
            return Errors.invalidUserInput.localizedDescription
        }
        return userInput
    }
}
