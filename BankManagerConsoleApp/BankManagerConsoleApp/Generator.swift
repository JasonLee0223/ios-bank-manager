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
        
        for index in 0...2 {
            let workType = workTypeList[index]
            tellers.append(Teller(identifier: workType))
        }
        return tellers
    }
    
    func randomCustomerCount() -> Int {
        return Int.random(in: CustomerCount.minimum...CustomerCount.maxmimum)
    }
}
