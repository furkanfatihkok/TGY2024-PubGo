//
//  SeatPlanViewController.swift
//  PubGo
//
//  Created by FFK on 25.04.2024.
//

import UIKit

class SeatPlanViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var seatLabel: UILabel!
    
    var selectedSeats: [IndexPath] = []
    let maxSelectedSeats = 5
    var passengerTicket: Ticket?
    
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
    
    private func updateLabel(with text: String, for indexPath: IndexPath) {
        seatLabel.text = text
    }
    
    @IBAction func bookNowButtonTapped(_ sender: UIButton) {
        let selectedSeatCount = selectedSeats.count
        
        if selectedSeatCount > 0 && selectedSeatCount <= maxSelectedSeats {
            self.performSegue(withIdentifier: "seatPlanToInfoTicket", sender: nil)
        } else if selectedSeatCount == 0 {
            AlertManager.showAlert(title: "Koltuk Seçim Uyarısı", message: "En az 1 tane koltuk seçin", viewController: self)
        } else {
            print("En fazla 5 koltuk seçebilirisniz")
        }
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
            if selectedSeats.contains(indexPath) {
                if let selectedIndex = selectedSeats.firstIndex(of: indexPath) {
                    selectedSeats.remove(at: selectedIndex)
                }
                collectionView.cellForItem(at: indexPath)?.backgroundColor = seatColors[.available]
                updateLabel(with: "", for: indexPath)
            } else {
                if selectedSeats.count < maxSelectedSeats {
                    AlertManager.showBookingAlert(on: self) { [weak self] name, surname, tcNumber in
                        guard let self = self else { return }
                        if let name = name, let surname = surname, let tcNumber = tcNumber {
                            self.selectedSeats.append(indexPath)
                            collectionView.cellForItem(at: indexPath)?.backgroundColor = self.seatColors[.chosen]
                            self.updateLabel(with: "TC: \(tcNumber), \(name), \(surname)", for: indexPath)
                        }
                    }
                } else {
                    AlertManager.showAlert(title: "Koltuk Seçim Uyarısı", message: "En Fazla 5 tane koltuk seçebilirsiniz!!", viewController: self)
                }
            }
        } else {
            AlertManager.showAlert(title: "Koltuk Seçim Uyarısı", message: "Gri renkteki koltuklara seçim yapamazsınız!", viewController: self)
        }
        
        for seatIndexpath in selectedSeats {
            if seatIndexpath != indexPath {
                collectionView.cellForItem(at: seatIndexpath)?.backgroundColor = seatColors[.chosen]
            }
        }
    }
}
