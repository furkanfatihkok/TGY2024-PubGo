//
//  Ticket.swift
//  PubGo
//
//  Created by FFK on 26.04.2024.
//

import Foundation

class Ticket {
    var passenger: Passenger
    var date: Date
    var time: Time
    var seat: [Int]
    var seatCount: Int
    var from: String
    var to: String
    
    init(passenger: Passenger = Passenger(), date: Date = Date(), time: Time = Time()) {
        self.passenger = passenger
        self.date = date
        self.time = time
        self.seat = []
        self.seatCount = 0
        self.from = ""
        self.to = ""
    }
    
    func compare(otherTickets: Ticket) -> Bool {
        for seatNo in self.seat {
            if otherTickets.seat.contains(seatNo){
                print("This seat or seats have been selected")
                return true
            }
        }
        return false
    }
    
    func reserveSeats(seatCount: Int) {
        if seatCount > 0 && seatCount <= 5 {
            self.seatCount = seatCount
            var seats = [Int]()
            for seatNumber in 1...seatCount {
                seats.append(seatNumber)
            }
            self.seat = seats
        }
    }
    
    func addSeatNumber(number: Int) {
        if number >= 1 && number <= 32 {
            self.seat.append(number)
        }
    }
    
    func printTicket() {
        let passengerInfo = "\(passenger.name), \(passenger.surname), \(passenger.id)"
        let dateInfo = "\(date.day)/\(date.month)/\(date.year)"
        let timeInfo = "\(time.hour):\(time.minute)"
        
        print("\(passengerInfo), \(dateInfo), \(timeInfo)")
    }
}

