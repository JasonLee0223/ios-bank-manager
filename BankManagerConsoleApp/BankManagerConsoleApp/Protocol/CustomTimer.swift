//
//  CustomTimer.swift
//  BankManagerConsoleApp
//
//  Created by Jason on 2023/03/22.
//

import Foundation

protocol CustomTimer {
    var timerState: TimerState { get }
    
    func start(durationSeconds: Double,
               repeatingExecution: (() -> Void)?)
    func resume()
    func suspend()
    func cancel()
}
