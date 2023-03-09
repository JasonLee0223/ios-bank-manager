//
//  WorkType.swift
//  BankManagerConsoleApp
//
//  Created by Jason on 2023/03/09.
//

import Foundation

enum WorkType: String, CustomStringConvertible {
    case deposit = "예금"
    case loan = "대출"
    
    var description: String {
        return self.rawValue
    }
    
    var leadTime: Double {
        switch self {
        case .deposit:
            return 0.7
        case .loan:
            return 1.1
        }
    }
}
