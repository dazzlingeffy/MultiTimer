//
//  File.swift
//  MultiTimer
//
//  Created by ira on 07.07.2021.
//

import UIKit

class TimerState {
    var seconds: Int
    var timer: Timer!
    var sec: Int
    var min: Int
    var name: String
    
    init(name: String, seconds: Int) {
        self.name = name
        self.seconds = seconds
        min = (seconds % 3600) / 60
        sec = (seconds % 3600) % 60
        setTimer()
    }
    
    func setTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        self.seconds -= 1
        self.sec -= 1
        if (self.seconds == 0) {
            self.timer.invalidate()
        }
        if (self.sec < 0) {
            self.sec = 59
            if (self.min != 0) {
                self.min -= 1
            }
        }
        TimersTableView.instance.reloadData()
        print("\(name):\(seconds)")
    }
}
