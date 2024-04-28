//
//  Passenger.swift
//  PubGo
//
//  Created by FFK on 26.04.2024.
//

import Foundation

class Passenger {
    var name: String
    var surname: String
    var id: Int
    
    init(name: String = "No Name", surname: String = "No Name", id: Int = 0) {
        self.name = name
        self.surname = surname
        self.id = id
    }
}
