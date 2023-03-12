//
//  GeoData.swift
//  WeatherApp
//
//  Created by Otto Dzhandzhuliya on 07.03.2023.
//

import Foundation

struct GeoDatum: Codable {
    let name: String
    let localNames: [String: String]?
    let lat, lon: Double
 

    enum CodingKeys: String, CodingKey {
        case name
        case localNames = "local_names"
        case lat, lon
    }
}

typealias GeoData = [GeoDatum]
