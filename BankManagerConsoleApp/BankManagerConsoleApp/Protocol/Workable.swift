//
//  Workable.swift
//  BankManagerConsoleApp
//
//  Created by Jason on 2023/02/23.
//

import Foundation

protocol Workable {
    var identifier: WorkType { get }
    func working(responsibility: WorkType)
    func finishing() -> WorkType?
}
