//
//  OnboardingViewController.swift
//  bilet-yolcu-odevi
//
//  Created by FFK on 22.04.2024.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    let onboardingArray = onboardingData()
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            
            if currentPage == onboardingArray.count - 1 {
                nextButton.setTitle("Get Started", for: .normal)
                nextButton.setTitleColor(.white, for: .normal)
            } else {
                nextButton.setTitle("Next", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    @IBAction func nextButtonAction(_ sender: UIButton) {
        
    }
    
}

    func onboardingData() -> [OnboardingModel] {
    
    [
        OnboardingModel(imageView: UIImage(named: "onboarding-1")!, title: "Travel smarter with Busify!", description: "Avoid the hassle of standing in long queues for bus tickets. Book with Busify and travel smarter, faster, and hassle-free."),
        OnboardingModel(imageView: UIImage(named: "onboarding-2")!, title: "Your one-stop ticket shop!", description: "Detail: Purchase bus tickets with ease, anytime and anywhere. Skip the queues and travel with peace of mind using our app.")
    ]
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        onboardingArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        UICollectionViewCell()
    }
}
