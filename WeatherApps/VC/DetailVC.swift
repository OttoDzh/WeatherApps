//
//  DetailVC.swift
//  WeatherApps
//
//  Created by Otto Dzhandzhuliya on 09.03.2023.
//

import UIKit
import Gifu
import CoreData

protocol UpdateViews {
    func reloadUI()
}

class DetailVC: UIViewController {
    
    let detailView = DetailView()
    let time = Date()
    let userDefaults = UserDefaults.standard
    var delegate: UpdateViews?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = detailView
        NetworkService.getInfoDate { border in
            DispatchQueue.main.async {
                self.detailView.borderActivityLabel.text = "Here is some activity for you: \(border.activity)"
            }
        }
        addTargets()
        hideAddButton()
    }
    
    func hideAddButton() {
        let newArrayCiti = userDefaults.stringArray(forKey: "Citiarray")
        let cityName = detailView.cityName.text!
        if newArrayCiti!.contains(cityName) {
            detailView.addCityButton.isHidden = true
        } else {
            detailView.addCityButton.isHidden = false
        }
    }
    
    func addTargets() {
        detailView.addCityButton.addTarget(self, action: #selector(addCity), for: .touchUpInside)
    }
    
    @objc func addCity() {
        var newArrayCiti = userDefaults.stringArray(forKey: "Citiarray")
        NetworkService.getLatLon(city: detailView.cityName.text!) { latlon in
            NetworkService.getWeather(latitude: latlon.first!.lat, longitute: latlon.first!.lon) { weather in
                DispatchQueue.main.async {
                    newArrayCiti?.append(latlon.first!.name)
                    self.userDefaults.set(newArrayCiti, forKey: "Citiarray")
                }
            }
        }
        self.delegate?.reloadUI()
        self.dismiss(animated: true)
    }
    }


