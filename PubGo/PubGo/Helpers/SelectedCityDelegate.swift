//
//  SelectedCityDelegate.swift
//  PubGo
//
//  Created by FFK on 28.04.2024.
//

import Foundation

protocol SelectedCityDelegate: AnyObject {
    func selectedCity(_ city: String, direction: Direction)
}
