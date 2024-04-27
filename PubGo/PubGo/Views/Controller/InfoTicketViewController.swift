//
//  InfoTicketViewController.swift
//  PubGo
//
//  Created by FFK on 25.04.2024.
//

import UIKit

class InfoTicketViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func cancelButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "backToSeatPlan", sender: nil)
    }
}
