//
//  SeatSelectionDelegate.swift
//  PubGo
//
//  Created by FFK on 28.04.2024.
//

import Foundation

protocol SeatSelectionDelegate: AnyObject {
    func didSelectSeats(_ seats: [(name: String, surname: String, tcNumber: String)])
}
