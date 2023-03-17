//
//  BorderActivity.swift
//  WeatherApps
//
//  Created by Otto Dzhandzhuliya on 12.03.2023.
//

import Foundation

// MARK: - BorderActivity
struct BorderActivity: Codable {
    let activity, type: String
    let participants: Int
    let price: Double
    let link, key: String
    let accessibility: Double
}
