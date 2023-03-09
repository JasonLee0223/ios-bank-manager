//
//  Queue.swift
//  BankManagerConsoleApp
//
//  Created by devxsby on 2023/02/21.
//

import Foundation

struct Queue<Customer> {
    private var queue: LinkedList = LinkedList<Customer>()
    
    var count: Int {
        return queue.count
    }
    
    var isEmpty: Bool {
        return queue.isEmpty
    }
    
    mutating func euqueue(_ item: Customer) {
        queue.append(item)
    }
    
    mutating func dequeue() -> Customer? {
        return queue.pop()
    }
    
    mutating func peek() -> Customer? {
        return queue.first
    }
    
    mutating func clear() {
        queue.removeAll()
    }
}
