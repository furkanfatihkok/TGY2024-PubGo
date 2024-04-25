//
//  Time.swift
//  PubGo
//
//  Created by FFK on 26.04.2024.
//

import Foundation

class Time {
    var hour: Int
    var minute: Int
    
    init(hour: Int = 0, minute: Int = 0) {
        self.hour = hour
        self.minute = minute
    }
    
    func printTime() {
        print("\(hour):\(minute)")
    }
}
