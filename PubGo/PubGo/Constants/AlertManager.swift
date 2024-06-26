//
//  AlertManager.swift
//  PubGo
//
//  Created by FFK on 27.04.2024.
//

import UIKit

class AlertManager {
    
    var ticket: Ticket = Ticket()
    
    static func showBookingAlert(on viewController: UIViewController, completion: @escaping (String?, String?, String?) -> Void) {
        let alertController = UIAlertController(title: "Bilet Bilgileri", message: "Lütfen ad, soyad ve TC kimlik numaranızı girin", preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "Adınız"
        }
        
        alertController.addTextField { textField in
            textField.placeholder = "Soyadınız"
        }
        
        alertController.addTextField { textField in
            textField.placeholder = "TC Kimlik Numaranız"
            textField.keyboardType = .numberPad
        }
        
        let confirmAction = UIAlertAction(title: "Bilet Al", style: .default) { _ in
            
            guard let name = alertController.textFields?[0].text, !name.isEmpty else {
                showAlert(title: "Uyarı", message: "Lütfen adınızı giriniz!", viewController: viewController)
                return
            }
            
            guard let surname = alertController.textFields?[1].text, !surname.isEmpty else {
                showAlert(title: "Uyarı", message: "Lütfen soyadınızı giriniz!", viewController: viewController)
                return
            }
            
            guard let tcNumber = alertController.textFields?[2].text, !tcNumber.isEmpty else {
                showAlert(title: "Uyarı", message: "Lütfen TC kimlik numaranızı giriniz!", viewController: viewController)
                return
            }
            
            completion(name, surname, tcNumber)
        }
        alertController.addAction(confirmAction)
        
        alertController.addAction(UIAlertAction(title: "İptal", style: .destructive))
        
        viewController.present(alertController, animated: true)
    }
    
    static func showAlert(title: String, message: String, viewController: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let confirmationAction = UIAlertAction(title: "Tamam", style: .default)
        alertController.addAction(confirmationAction)
        
        viewController.present(alertController, animated: true)
    }
    
}
