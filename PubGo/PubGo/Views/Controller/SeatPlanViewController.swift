////
////  SeatPlanViewController.swift
////  PubGo
////
////  Created by FFK on 25.04.2024.
////
//
import UIKit

class SeatPlanViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var seatLabel: UILabel!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var minuteLabel: UILabel!
    
    var selectedDate: Foundation.Date?
    
    var selectedTime: Foundation.Date?
    
    var selectedSeats: [IndexPath] = []
    
    let maxSelectedSeats = 5
    
    var passengerTicket: Ticket = Ticket()
    
    let seatStatuses: [[SeatStatus]] = [
        [.available, .available, .empty, .filled, .available],
        [.filled, .filled, .empty, .available, .filled],
        [.available, .available, .empty, .available, .available],
        [.filled, .filled, .empty, .available, .filled],
        [.filled, .filled, .empty, .chosen, .filled],
        [.available, .available, .empty, .filled, .filled],
        [.available, .available, .empty, .available, .available],
        [.filled, .filled, .empty, .available, .available]
    ]
    
    let seatColors: [SeatStatus: UIColor] = [
        .available: .appBlue,
        .filled: UIColor.gray,
        .chosen: .appGreen,
        .empty: UIColor.clear
    ]
    
    let cellSize: CGFloat = 40
    let interItemSpacing: CGFloat = 8
    let interSectionSpacing: CGFloat = 16
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let selectedDate = selectedDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            let dateString = dateFormatter.string(from: selectedDate)
            timeLabel.text = dateString
        }
        
        if let selectedTime = selectedTime {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            let timeString = dateFormatter.string(from: selectedTime)
            minuteLabel.text = timeString
        }
        
        
        titleLabel.text = (passengerTicket.from + " - " + passengerTicket.to)
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = interItemSpacing
        layout.minimumLineSpacing = interSectionSpacing
        layout.itemSize = CGSize(width: cellSize, height: cellSize)
        layout.headerReferenceSize = CGSize(width: 40, height: 40)
        collectionView.collectionViewLayout = layout
        
    }
    
    private func updateLabel(with text: String, for indexPath: IndexPath) {
        seatLabel.text = text
    }
    
    @IBAction func bookNowButtonTapped(_ sender: UIButton) {
        if selectedSeats.isEmpty {
            AlertManager.showAlert(title: "Koltuk Seçimi", message: "Lütfen en az bir koltuk seçiniz!", viewController: self)
        } else {
            AlertManager.showBookingAlert(on: self) { [weak self] name, surname, tcNumber in
                guard let self = self else { return }
                if let name = name, let surname = surname, let tcNumber = tcNumber {
                    self.passengerTicket.passenger.name = name
                    self.passengerTicket.passenger.surname = surname
                    self.passengerTicket.passenger.id = Int(tcNumber) ?? self.passengerTicket.passenger.id
                    
                    self.performSegue(withIdentifier: "seatPlanToInfoTicket", sender: self.passengerTicket)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seatPlanToInfoTicket",
           let infoTicketVC = segue.destination as? InfoTicketViewController  {
            infoTicketVC.ticket = passengerTicket
            infoTicketVC.selectedDate = selectedDate
            infoTicketVC.selectedTime = selectedTime
            infoTicketVC.seatLabelText = seatLabel.text
        }
    }
}

extension SeatPlanViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 32)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return seatStatuses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return seatStatuses[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "seatCell", for: indexPath)
        let seatStatus = seatStatuses[indexPath.section][indexPath.item]
        cell.layer.cornerRadius = 12
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
                            self.selectedSeats.append(indexPath)
                            collectionView.cellForItem(at: indexPath)?.backgroundColor = self.seatColors[.chosen]
                            self.updateLabel(with: "\(indexPath)", for: indexPath)
                    } else {
                    AlertManager.showAlert(title: "Koltuk Seçim Uyarısı", message: "En Fazla 5 tane koltuk seçebilirsiniz!!", viewController: self)
                }
            }
        } else if selectedSeatStatus == .chosen {
            AlertManager.showAlert(title: "Koltuk Seçim Uyarısı", message: "Yeşil renkteki koltuk seçim aşamasındadır", viewController: self)
        } else if selectedSeatStatus == .empty {
            return
        } else {
            AlertManager.showAlert(title: "Koltuk Seçim Uyarısı", message: "Gri renkteki koltuklara seçim yapamazsınız!", viewController: self)
        }
        
        for seatIndexpath in selectedSeats {
            if seatIndexpath != indexPath {
                collectionView.cellForItem(at: seatIndexpath)?.backgroundColor = seatColors[.chosen]
            }
        }
    }
    
    
    //    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    //        if kind == UICollectionView.elementKindSectionHeader {
    //            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerView", for: indexPath)
    //            let label = UILabel(frame: CGRect(x: 0, y: 0, width: headerView.frame.width, height: headerView.frame.height))
    //            label.textAlignment = .center
    //            label.font = UIFont.boldSystemFont(ofSize: 16.0)
    //            switch indexPath.section {
    //            case 0:
    //                label.text = "A"
    //            case 1:
    //                label.text = "B"
    //            case 2:
    //                label.text = ""
    //            case 3:
    //                label.text = "C"
    //            case 4:
    //                label.text = "D"
    //            default:
    //                label.text = ""
    //            }
    //            headerView.addSubview(label)
    //            return headerView
    //        } else {
    //            fatalError("unkonwn")
    //        }
    //    }
    //
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    //        return CGSize(width: 50, height: 50)
    //    }
    //
}
