//
//  Requirement.swift
//  BankManagerConsoleApp
//
//  Created by Jason on 2023/02/23.
//

import Foundation

enum CustomerCount {
    static let defaultCustomer: Int = 1
    static let minimum: Int = 10
    static let maxmimum: Int = 30
}

enum WorkType: String, CustomStringConvertible, CaseIterable {
    case loan = "대출"
    case deposit = "예금"
    
    var description: String {
        return self.rawValue
    }
    
    var leadTime: TimeInterval {
        switch self {
        case .deposit:
            return 0.7
        case .loan:
            return 1.1
        }
    }
}
