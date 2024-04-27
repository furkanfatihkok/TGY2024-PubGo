//
//  AlertManager.swift
//  PubGo
//
//  Created by FFK on 27.04.2024.
//

import UIKit

class AlertManager {
    
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
            
            let name = alertController.textFields?[0].text ?? ""
            let surname = alertController.textFields?[1].text ?? ""
            let tcNumber = alertController.textFields?[2].text ?? ""
            completion(name, surname, tcNumber)
        }
        alertController.addAction(confirmAction)
        
        alertController.addAction(UIAlertAction(title: "İptal", style: .destructive))
        
        viewController.present(alertController, animated: true)
    }
    
    static func showConfirmationAlert(on viewController: UIViewController, completion: @escaping (Bool) -> Void) {
        let confirmAlert = UIAlertController(title: "Bilet Al", message: "Bilet almak istediğinizden emin misiniz?", preferredStyle: .alert)
        
        confirmAlert.addAction(UIAlertAction(title: "Evet", style: .default, handler: { _ in
            completion(true)
        }))
        
        confirmAlert.addAction(UIAlertAction(title: "Hayır", style: .destructive, handler: { _ in
            completion(false)
        }))
        
        viewController.present(confirmAlert, animated: true)
    }
}

