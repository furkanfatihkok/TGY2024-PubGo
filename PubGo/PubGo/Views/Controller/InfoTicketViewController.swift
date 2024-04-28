//
//  InfoTicketViewController.swift
//  PubGo
//
//  Created by FFK on 25.04.2024.
//

import UIKit

class InfoTicketViewController: UIViewController {

    @IBOutlet weak var passengerTCnumberLabel: UILabel!
    @IBOutlet weak var passengerName: UILabel!
    
    var ticket: Ticket = Ticket()
    
    var selectedSeats: [(name: String, surname: String, tcNumber: String)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let firstSeat = selectedSeats.first {
            passengerName.text = firstSeat.name
            passengerTCnumberLabel.text = firstSeat.tcNumber
        }

    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "backToSeatPlan", sender: nil)
    }
}
