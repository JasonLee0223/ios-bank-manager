//
//  LinkedList.swift
//  BankManagerConsoleApp
//
//  Created by Jason on 2023/02/21.
//

import Foundation

struct LinkedList<Customer> {
    private(set) var head: Node<Customer>?
    private(set) var tail: Node<Customer>?
    private(set) var count: Int = 0
            
    var first: Customer? {
        return head?.value
    }
    
    var last: Customer? {
        return tail?.value
    }
    
    var isEmpty: Bool {
        return head == nil
    }
    
    func node(at index: Int) -> Node<Customer>? {
        var currentNode = head
        var currentIndex = 0
        
        while currentNode != nil && currentIndex < index {
            currentNode = currentNode?.next
            currentIndex += 1
        }
        
        return currentNode
    }
    
    mutating func push(_ value: Customer) {
        head = Node(value: value, next: head)
        
        if tail == nil {
            tail = head
        }
        count += 1
    }
    
    mutating func append(_ value: Customer) {
        guard !isEmpty else {
            push(value)
            return
        }
        tail?.next = Node(value: value)
        tail = tail?.next
        count += 1
    }
    
    @discardableResult
    mutating func insert(_ value: Customer, after node: Node<Customer>) -> Node<Customer> {
        
        guard tail !== node else {
            append(value)
            return tail!
        }
        
        node.next = Node(value: value, next: node.next)
        count += 1
        
        return node.next!
    }
    
    @discardableResult
    mutating func pop() -> Customer? {
        let excludeData = head?.value
        head = head?.next
        
        if isEmpty {
            tail = nil
        }
        count -= 1
        
        return excludeData
    }
    
    @discardableResult
    mutating func remove(after node: Node<Customer>) -> Customer? {
        if node.next === tail {
            tail = node
        }
        
        node.next = node.next?.next
        count -= 1
        
        return node.next?.value
    }
    
    @discardableResult
    mutating func removeLast() -> Customer? {
        guard let head = head else { return nil }
        
        guard head.next != nil else {
            return pop()
        }
        
        var prev = head
        var current = head
        while let next = current.next {
            prev = current
            current = next
        }
        
        prev.next = nil
        tail = prev
        count -= 1
        
        return current.value
    }
    
    mutating func removeAll() {
        head = nil
        tail = nil
        count = 0
    }
}
