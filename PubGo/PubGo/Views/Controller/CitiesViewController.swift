//
//  CitiesViewController.swift
//  PubGo
//
//  Created by FFK on 28.04.2024.
//

import UIKit

enum Direction {
    case from
    case to
}

protocol CitiesViewControllerDelegate: AnyObject {
    func selectedCity(_ city: String, direction: Direction)
}

class CitiesViewController: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    
    weak var delegate: CitiesViewControllerDelegate?
    
    var direction: Direction = .from
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
}

extension CitiesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        City.cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath)
        cell.textLabel?.text = City.cities[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.selectedCity(City.cities[indexPath.row], direction: direction)
        dismiss(animated: true)
    }
}
