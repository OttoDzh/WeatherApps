//
//  GifCondition.swift
//  WeatherApps
//
//  Created by Otto Dzhandzhuliya on 15.03.2023.
//

import Foundation

enum GifConditionsForCell {
    case rain
    case snow
    case clouds
    case clearsky
    case thunderstorm
    case drizzle
    case rainNight
    case snowNight
    case clearskyNight
    case cloudsNight
}

func gifConditions(for cell: GifConditionsForCell) {
    
    let celKa = MyCell()
    
    switch cell {
    case .rain:
        celKa.gifBg.animate(withGIFNamed: "rain")
    case .snow:
        celKa.gifBg.animate(withGIFNamed: "snow")
    case .clouds:
        celKa.gifBg.animate(withGIFNamed: "clouds")
    case .clearsky:
        celKa.gifBg.animate(withGIFNamed: "clearsky")
    case .thunderstorm:
        celKa.gifBg.animate(withGIFNamed: "thunderstorm")
    case .drizzle:
        celKa.gifBg.animate(withGIFNamed: "drizzle")
    case .rainNight:
        celKa.gifBg.animate(withGIFNamed: "rainNight")
    case .snowNight:
        celKa.gifBg.animate(withGIFNamed: "snowNight")
    case .clearskyNight:
        celKa.gifBg.animate(withGIFNamed: "clearskyNight")
    case .cloudsNight:
        celKa.gifBg.animate(withGIFNamed: "cloudsNight")
    }
}
