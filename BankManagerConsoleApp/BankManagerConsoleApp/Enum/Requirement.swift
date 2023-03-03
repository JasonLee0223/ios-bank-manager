//
//  Requirement.swift
//  BankManagerConsoleApp
//
//  Created by Jason on 2023/02/23.
//

import Foundation

enum Requirement {
    
    enum CustomerCount {
        static let defaultCustomer: Int = 1
        static let minimum: Int = 10
        static let maxmimum: Int = 30
    }
    enum LeadTime {
        static let loan: Double = 1.1
        static let deposit: Double = 0.7
    }
}

enum WorkType: String, CustomStringConvertible {
    case loan = "대출"
    case deposit = "예금"
    
    var description: String {
        return self.rawValue
    }
}
