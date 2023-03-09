//
//  Generator.swift
//  BankManagerConsoleApp
//
//  Created by Jason on 2023/03/09.
//

import Foundation

struct Generator {
    func assignTellers() -> [Teller] {
        let workTypeList = [WorkType.deposit, WorkType.deposit, WorkType.loan].shuffled()
        var tellers = [Teller]()
        
        workTypeList.forEach { workType in
            tellers.append(workType)
        }
        return tellers
    }
    
    func randomCustomerCount() -> Int {
        return Int.random(in: CustomerCount.minimum...CustomerCount.maxmimum)
    }
}
