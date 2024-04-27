//
//  SeatPlanViewController.swift
//  PubGo
//
//  Created by FFK on 25.04.2024.
//

import UIKit

class SeatPlanViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    let seatStatuses: [[SeatStatus]] = [
        [.available, .available, .filled, .filled, .available],
        [.available, .available, .filled, .filled, .available],
        [.available, .available, .available, .filled, .available],
        [.available, .filled, .available, .filled, .available],
        [.available, .available, .filled, .available, .available]
    ]
    
    let seatColors: [SeatStatus: UIColor] = [
        .available: .blue,
        .filled: .gray,
        .chosen: .green
    ]
    
    let cellSize: CGFloat = 60
    let interItemSpacing: CGFloat = 8
    let interSectionSpacing: CGFloat = 16
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = interItemSpacing
        layout.minimumLineSpacing = interSectionSpacing
        layout.itemSize = CGSize(width: cellSize, height: cellSize)
        collectionView.collectionViewLayout = layout
        
        
    }
}

extension SeatPlanViewController: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return seatStatuses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return seatStatuses[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "seatCell", for: indexPath)
        let seatStatus = seatStatuses[indexPath.section][indexPath.item]
        cell.layer.cornerRadius = 10
        cell.backgroundColor = seatColors[seatStatus]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedSeatStatus = seatStatuses[indexPath.section][indexPath.item]
        
        if selectedSeatStatus == .available {
            AlertManager.showBookingAlert(on: self) { name, surname, tcNumber in
                print("Ad: \(String(describing: name)), Soyad: \(String(describing: surname)), TC Kimlik Numarası: \(String(describing: tcNumber))")
                
                AlertManager.showConfirmationAlert(on: self) { confirmed in
                    if confirmed {
                        print("Bilet Alındı")
                    } else {
                        print("Bilet Alınamadı....")
                    }
                }
            }
        } else if selectedSeatStatus == .chosen {
            print("Koltuk şu an seçim aşamasında")
        } else {
            print("Koltuk dolu seçim yapamazsınız.")
        }
    }
}
