//
//  ViewController.swift
//  Weather
//
//  Created by Otto Dzhandzhuliya on 08.03.2023.
//

import UIKit
import CoreData
import Gifu


class MainViewVC: UIViewController {
    
    var gifGB = GIFImageView()
    let userDefaults = UserDefaults.standard
    let mainView = MainView()
    var cities = [WeatherData]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = mainView
        mainView.table.delegate = self
        mainView.table.dataSource = self
        addTargets()
        getCities()
    }
    
    func addTargets() {
        mainView.addCityButton.addTarget(self, action: #selector(addCity), for: .touchUpInside)
    }
    @objc func addCity() {
        let alertController = UIAlertController(title: "AddCity", message: "Enter city name", preferredStyle: .alert)
        alertController.addTextField {(textfield: UITextField!) -> Void in
            textfield.placeholder = "City name"
        }
        let saveAction = UIAlertAction(title: "Add", style: .default, handler: { alert -> Void in
            let firsTexField = alertController.textFields![0] as UITextField
            guard let cityname = firsTexField.text else {return}
            NetworkService.getLatLon(city: cityname) { latlon in
                guard  ((latlon.first?.localNames?.values.contains("\(cityname)")) != nil) else {return}
                NetworkService.getWeather(latitude: latlon.first!.lat, longitute: latlon.first!.lon) { weather in
                    self.cities.append(weather)
                    var citiarray = self.userDefaults.stringArray(forKey: "Citiarray")
                    citiarray?.append(cityname)
                    self.userDefaults.set(citiarray, forKey: "Citiarray")
                    DispatchQueue.main.async{
                        self.mainView.table.reloadData()
                    }
                }
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
    }
    func getCities() {
        
        var newArrayCiti = userDefaults.stringArray(forKey: "Citiarray")
        if newArrayCiti == nil  {
            print("ITS NIL")
            newArrayCiti = ["Moscow","London"]
            userDefaults.set(newArrayCiti, forKey: "Citiarray")
            for citi in newArrayCiti! {
                NetworkService.getLatLon(city: citi) { latlon in
                    NetworkService.getWeather(latitude: latlon.first!.lat, longitute: latlon.first!.lon) { weather in
                        DispatchQueue.main.async {
                            self.cities.append(weather)
                            self.mainView.table.reloadData()
                        }
                    }
                }
            }
        } else  {
            for citi in newArrayCiti! {
                NetworkService.getLatLon(city: citi) { latlon in
                    NetworkService.getWeather(latitude: latlon.first!.lat, longitute: latlon.first!.lon) { weather in
                        DispatchQueue.main.async {
                            self.cities.append(weather)
                            self.mainView.table.reloadData()
                        }
                    }
                }
            }  
        }
    }
}
    
    extension MainViewVC: UITableViewDelegate, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            cities.count
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: MyCell.reuseId, for: indexPath) as! MyCell
            cell.cityName.text = self.cities[indexPath.row].name
            cell.tempLabbel.text = "\(Int(self.cities[indexPath.row].main.temp - 273))°"
            cell.maxTempLabel.text = "H: \(Int(self.cities[indexPath.row].main.tempMax - 273))°"
            cell.minTempLabel.text = "L: \(Int(self.cities[indexPath.row].main.tempMin - 273))°"
            cell.descrLabel.text = self.cities[indexPath.row].weather.first?.main
            cell.contentView.backgroundColor = UIColor.clear
            if cell.descrLabel.text == "Rain" {
                cell.gifBg.animate(withGIFNamed: "rain")
            } else if cell.descrLabel.text == "Snow" {
                cell.gifBg.animate(withGIFNamed: "snow")
            } else if cell.descrLabel.text == "Clouds"{
                cell.gifBg.animate(withGIFNamed: "clouds")
            } else if cell.descrLabel.text == "Clear" {
                cell.gifBg.animate(withGIFNamed: "clearsky")
            } else if cell.descrLabel.text == "Thunderstorm" {
                cell.gifBg.animate(withGIFNamed: "thunderstorm")
            }
            cell.layer.cornerRadius = 15
            return cell
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            120
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let vc = DetailVC()
            vc.detailView.cityName.text = self.cities[indexPath.row].name
            vc.detailView.tempLabel.text = "\(Int(self.cities[indexPath.row].main.temp - 273))°"
            vc.detailView.cloudyLabel.text = self.cities[indexPath.row].weather.first?.main
            self.present(vc, animated: true)
        }
        func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
           
            let deleteAction = UIContextualAction(style: .normal, title: nil) { _, _, _ in
                var arrayDefault = self.userDefaults.stringArray(forKey: "Citiarray")
                arrayDefault?.remove(at: indexPath.row)
                self.userDefaults.set(arrayDefault, forKey: "Citiarray")
                self.cities.remove(at: indexPath.row)
                self.mainView.table.reloadData()
            }
            
            let largeConfig = UIImage.SymbolConfiguration(pointSize: 37.0, weight: .bold, scale: .large)
            deleteAction.image = UIImage(systemName: "trash", withConfiguration: largeConfig)?.withTintColor(.white, renderingMode: .alwaysTemplate).addBackgroundCircle(.systemRed)
            deleteAction.title = "Delete"
            deleteAction.backgroundColor = .black
            let config = UISwipeActionsConfiguration(actions: [deleteAction])
            return config
        }
    }

extension UIImage {

    func addBackgroundCircle(_ color: UIColor?) -> UIImage? {

        let circleDiameter = max(size.width * 2, size.height * 2)
        let circleRadius = circleDiameter * 0.5
        let circleSize = CGSize(width: circleDiameter, height: circleDiameter)
        let circleFrame = CGRect(x: 0, y: 0, width: circleSize.width, height: circleSize.height)
        let imageFrame = CGRect(x: circleRadius - (size.width * 0.5), y: circleRadius - (size.height * 0.5), width: size.width, height: size.height)

        let view = UIView(frame: circleFrame)
        view.backgroundColor = color ?? .systemRed
        view.layer.cornerRadius = circleDiameter * 0.5

        UIGraphicsBeginImageContextWithOptions(circleSize, false, UIScreen.main.scale)

        let renderer = UIGraphicsImageRenderer(size: circleSize)
        let circleImage = renderer.image { ctx in
            view.drawHierarchy(in: circleFrame, afterScreenUpdates: true)
        }

        circleImage.draw(in: circleFrame, blendMode: .normal, alpha: 1.0)
        draw(in: imageFrame, blendMode: .normal, alpha: 1.0)

        let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()

        return image
    }
}
    

