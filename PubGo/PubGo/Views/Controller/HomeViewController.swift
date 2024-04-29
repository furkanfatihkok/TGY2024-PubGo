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
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var ticket: Ticket = Ticket()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.addTarget(self, action: #selector(tapped), for: .valueChanged)
    }
    
    @objc func tapped() {
        dismiss(animated: true)
    }
    
    @IBAction func serachTicketButton(_ sender: UIButton) {
        guard let fromCity = fromButtonLabel.title(for: .normal),
              let toCity = toButton.title(for: .normal),
              !fromCity.isEmpty, !toCity.isEmpty else {
            AlertManager.showAlert(title: "Uyarı!", message: "Lütfen Şehir Seçin", viewController: self)
            return
        }
        performSegue(withIdentifier: "homeToSeatPlan", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cityVC = segue.destination as? CitiesViewController {
            cityVC.delegate = self
            cityVC.direction = segue.identifier == "from" ? .from : .to
        }
        
        if let seatPlanVC = segue.destination as? SeatPlanViewController {
            seatPlanVC.passengerTicket = ticket
            seatPlanVC.selectedDate = datePicker.date
            seatPlanVC.selectedTime = datePicker.date
        }
        
    }
    
}
extension HomeViewController: SelectedCityDelegate {
    
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


