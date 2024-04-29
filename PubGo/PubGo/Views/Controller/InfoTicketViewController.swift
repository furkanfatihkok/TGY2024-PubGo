//
//  InfoTicketViewController.swift
//  PubGo
//
//  Created by FFK on 25.04.2024.
//

import UIKit

class InfoTicketViewController: UIViewController {

    @IBOutlet weak var fromCityLabel: UILabel!
    @IBOutlet weak var toCityLabel: UILabel!
    
     
    @IBOutlet weak var timeFromLabel: UILabel!
    @IBOutlet weak var timeToLabel: UILabel!
    
    @IBOutlet weak var dateFromLabel: UILabel!
    @IBOutlet weak var dateToLabel: UILabel!
    
    
    @IBOutlet weak var passengerTCnumberLabel: UILabel!
    @IBOutlet weak var passengerName: UILabel!
    
    @IBOutlet weak var seatPlanLabel: UILabel!
    
    var ticket: Ticket = Ticket()
    var selectedDate: Foundation.Date?
    var selectedTime: Foundation.Date?
    var seatLabelText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fromCityLabel.text = ticket.from
        toCityLabel.text = ticket.to
        
        passengerName.text = ticket.passenger.name + " " + ticket.passenger.surname
        passengerTCnumberLabel.text = "\(ticket.passenger.id)"
        
        if let selectedDate = selectedDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            let dateString = dateFormatter.string(from: selectedDate)
            dateFromLabel.text = dateString
            dateToLabel.text = dateString
        }
        
        if let selectedTime = selectedTime {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            let timeString = dateFormatter.string(from: selectedTime)
            timeFromLabel.text = timeString
            timeToLabel.text = timeString
        }
        
        seatPlanLabel.text = seatLabelText ?? ""
        
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "backToHome", sender: nil)
    }
}
