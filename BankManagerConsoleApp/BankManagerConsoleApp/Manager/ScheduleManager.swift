//
//  ScheduleManager.swift
//  BankManagerConsoleApp
//
//  Created by Jason on 2023/03/22.
//

import Foundation

final class ScheduleManager: CustomTimer {
    
    //MARK: - Initializer
    deinit {
        removeTimer()
    }

    //MARK: - Property
    var timerState = TimerState.suspended
    
    //MARK: - Private Property
    private var repeatingExecution: (() -> Void)?
    private var completion: (() -> Void)?
    private var timers: (repeatTimer: DispatchSourceTimer?, nonRepeatTimer: DispatchSourceTimer?) = (DispatchSource.makeTimerSource(),
                                                                                                  DispatchSource.makeTimerSource())
    //MARK: - Method
    func start(durationSeconds: Double, repeatingExecution: (() -> Void)?) {
        setTimer(durationSeconds: durationSeconds, repeatingExecution: repeatingExecution, completion: completion)
        resume()
    }
    
    func resume() {
        guard timerState == .suspended else {
            return
        }
        timerState = .resumed
        timers.repeatTimer?.resume()
        timers.nonRepeatTimer?.resume()
    }
    
    func suspend() {
        guard timerState == .resumed else {
            return
        }
        timerState = .suspended
        timers.repeatTimer?.suspend()
        timers.nonRepeatTimer?.suspend()
    }
    
    func cancel() {
        timerState = .canceled
        initTimer()
    }
    
    private func finish() {
        timerState = .finished
        cancel()
    }
}

//MARK: - Private Method
extension ScheduleManager {
    private func initTimer() {
        timers.repeatTimer?.setEventHandler(handler: nil)
        timers.nonRepeatTimer?.setEventHandler(handler: nil)
        
        repeatingExecution = nil
        completion = nil
    }
    
    private func setTimer(durationSeconds: Double,
                          repeatingExecution: (() -> Void)?, completion: (() -> Void)?) {
        initTimer()
        
        self.repeatingExecution = repeatingExecution
        self.completion = completion
        
        timers.repeatTimer?.schedule(deadline: .now(), repeating: 1)
        timers.repeatTimer?.setEventHandler(handler: repeatingExecution)
        
        timers.nonRepeatTimer?.schedule(deadline: .now() + durationSeconds)
        timers.nonRepeatTimer?.setEventHandler(handler: { [weak self] in
            self?.finish()
            completion?()
        })
    }
    
    private func removeTimer() {
        // cancel()을 한 번 실행하면 timer를 다시 사용할 수 없는 상태임을 주의
        // cancel()을 할 떈 resume()을 호출한 후 실행해야 충돌이 나지 않고 정상 취소 가능
        timers.repeatTimer?.resume()
        timers.nonRepeatTimer?.resume()
        
        timers.repeatTimer?.cancel()
        timers.nonRepeatTimer?.cancel()
        initTimer()
    }
}
