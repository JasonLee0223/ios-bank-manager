//
//  Node.swift
//  BankManagerConsoleApp
//
//  Created by devxsby on 2023/02/21.
//

import Foundation

final class Node<Customer> {
    let value: Customer
    var next: Node?
    
    init(value: Customer, next: Node? = nil) {
        self.value = value
        self.next = next
    }
}
