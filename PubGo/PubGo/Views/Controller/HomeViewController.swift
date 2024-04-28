//
//  ViewController.swift
//  PubGo
//
//  Created by FFK on 24.04.2024.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var fromButtonLabel: UIButton!
    @IBOutlet weak var toButton: UIButton!
    
    
    var ticket: Ticket = Ticket()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func serachTicketButton(_ sender: UIButton) {
        performSegue(withIdentifier: "homeToSeatPlan", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cityVC = segue.destination  as? CitiesViewController {
            cityVC.delegate = self
            cityVC.direction = segue.identifier == "nereden" ? .from : .to
        }
        if let seatPlanVC = segue.destination as? SeatPlanViewController {
//            injection dependency 2 tane var
            seatPlanVC.passengerTicket = ticket
        }
    }
    
}
extension HomeViewController: CitiesViewControllerDelegate {
    
    func selectedCity(_ city: String, direction: Direction) {
        if direction == .from {
            fromButtonLabel.setTitle(city, for: .normal)
            ticket.from = city
        } else {
            toButton.setTitle(city, for: .normal)
            ticket.to = city
        }
    }
    
}


