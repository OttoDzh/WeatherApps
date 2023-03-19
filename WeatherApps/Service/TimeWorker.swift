//
//  TimeWorker.swift
//  WeatherApps
//
//  Created by Otto Dzhandzhuliya on 19.03.2023.
//

import Foundation

class TimeWorker {
    
    static func getCurrentTime(time:Double) -> Int {
        let date = Date(timeIntervalSinceNow: time)
        let formater = DateFormatter()
        formater.dateFormat = "HH"
        var localHour = Int(formater.string(from: date))!
        if localHour == 0 {
            localHour = 24 - 3
        } else if localHour == 1 {
            localHour = 25 - 3
        } else if localHour == 2 {
            localHour = 26 - 3
        } else if localHour == 3 {
            localHour = 27 - 3
        } else {
            localHour = Int(formater.string(from: date))! - 3
        }
        return localHour
    }
    
   static func getFormattedLocalTime(time:Double) -> String {
        let date = Date(timeIntervalSinceNow: time)
        let formater = DateFormatter()
        formater.dateFormat = "HH:mm"
        formater.timeZone = TimeZone(abbreviation: "GMT")
        let formatedDate = formater.string(from: date)
        return formatedDate
    }
    
}
