//
//  Workable.swift
//  BankManagerConsoleApp
//
//  Created by Jason on 2023/02/23.
//

import Foundation

protocol Workable {
    var identifier: String { get }
    func working(responsibility: String, at orderNumber: Int)
    func finishing() -> Int?
}
