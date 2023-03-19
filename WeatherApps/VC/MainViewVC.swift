//
//  ViewController.swift
//  Weather
//
//  Created by Otto Dzhandzhuliya on 08.03.2023.
//

import UIKit
import CoreData
import Gifu
import AVFoundation
import Network

class MainViewVC: UIViewController {
    
    var gifGB = GIFImageView()
    let userDefaults = UserDefaults.standard
    let mainView = MainView()
    var cities = [WeatherData]()
    var filteredCities = [String]()
    let dayHour = 6...18
    var player : AVAudioPlayer!
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.networkMonitoring()
        self.view = mainView
        mainView.searchBar.delegate = self
        mainView.table.delegate = self
        mainView.table.dataSource = self
        addTargets()
        getCities()
        self.mainView.table.refreshControl = refreshControl
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        mainView.searchBar.endEditing(true)
    }
    
    @objc func refreshTable() {
        self.mainView.table.reloadData()
        refreshControl.endRefreshing()
    }
    
    fileprivate func networkMonitoring() {
        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "monitoring")
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                switch path.status {
                case .satisfied:
                    print("Intenet connected")
                case .unsatisfied:
                    self.mainView.addCityButton.isHidden = true
                    self.mainView.weatherLabel.textColor = .red
                    self.mainView.weatherLabel.text = "Check your internet connection"
                case .requiresConnection:
                    print("May be activated")
                @unknown default:  fatalError()
                }
            }
        }
    }
    
    func addTargets() {
        mainView.addCityButton.addTarget(self, action: #selector(addCity), for: .touchUpInside)
    }
    
    func playSound(resource: String) {
        let url = Bundle.main.url(forResource: resource, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    
    @objc func addCity() {
        let alertController = UIAlertController(title: "AddCity", message: "Enter city name", preferredStyle: .alert)
        alertController.addTextField {(textfield: UITextField!) -> Void in
            textfield.placeholder = "City name"
        }
        let saveAction = UIAlertAction(title: "Add", style: .default, handler: { alert -> Void in
            let firsTexField = alertController.textFields![0] as UITextField
            guard let cityname = firsTexField.text else { return }
            NetworkService.getLatLon(city: cityname) { latlon in
                guard  ((latlon.first?.localNames?.values.contains("\(cityname)")) != nil) else {return}
                NetworkService.getWeather(latitude: latlon.first!.lat, longitute: latlon.first!.lon) { weather in
                    let weatherS = WeatherData(weather: weather.weather, main: weather.main, wind: weather.wind, name: latlon.first!.name, timezone: weather.timezone, id: weather.id)
                    self.cities.append(weatherS)
                    var citiarray = self.userDefaults.stringArray(forKey: "Citiarray")
                    citiarray?.append(cityname)
                    self.userDefaults.set(citiarray, forKey: "Citiarray")
                    DispatchQueue.main.async{
                        self.mainView.table.reloadData()
                    }
                }
                self.playSound(resource: "addCitySound")
            }
        }
        )
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
    }
    func getCities() {
        var newArrayCiti = userDefaults.stringArray(forKey: "Citiarray")
        if newArrayCiti == nil  {
            newArrayCiti = ["Moscow","London"]
            userDefaults.set(newArrayCiti, forKey: "Citiarray")
            for citi in newArrayCiti! {
                NetworkService.getLatLon(city: citi) { latlon in
                    NetworkService.getWeather(latitude: latlon.first!.lat, longitute: latlon.first!.lon) { weather in
                        let weatherS = WeatherData(weather: weather.weather, main: weather.main, wind: weather.wind, name: latlon.first!.name, timezone: weather.timezone, id: weather.id)
                        DispatchQueue.main.async {
                            self.cities.append(weatherS)
                            self.mainView.table.reloadData()
                        }
                    }
                }
            }
        } else  {
            for citi in newArrayCiti! {
                NetworkService.getLatLon(city: citi) { latlon in
                    NetworkService.getWeather(latitude: latlon.first!.lat, longitute: latlon.first!.lon) { weather in
                        let weatherS = WeatherData(weather: weather.weather, main: weather.main, wind: weather.wind, name: latlon.first!.name, timezone: weather.timezone, id: weather.id)
                        DispatchQueue.main.async {
                            self.cities.append(weatherS)
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
        cell.backgroundColor = .black
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.black
        cell.selectedBackgroundView = bgColorView
        cell.cityName.text = self.cities[indexPath.row].name
        cell.tempLabbel.text = "\(Int(self.cities[indexPath.row].main.temp - 273))°"
        cell.maxTempLabel.text = "H: \(Int(self.cities[indexPath.row].main.tempMax - 273))°"
        cell.minTempLabel.text = "L: \(Int(self.cities[indexPath.row].main.tempMin - 273))°"
        cell.descrLabel.text = self.cities[indexPath.row].weather.first?.main
        let doubleTz = Double(self.cities[indexPath.row].timezone)
        let localHour = TimeWorker.getCurrentTime(time: doubleTz)
        let currentTime = TimeWorker.getFormattedLocalTime(time: doubleTz)
        cell.localTimeLabel.text = "\(currentTime)"
        if cell.descrLabel.text == WeatherConditions.rain.rawValue && dayHour.contains(localHour) {
            cell.gifBg.animate(withGIFNamed: "rain")
        } else if cell.descrLabel.text == WeatherConditions.rain.rawValue  {
            cell.gifBg.animate(withGIFNamed: "rainNight")
        } else if cell.descrLabel.text == WeatherConditions.snow.rawValue && dayHour.contains(localHour) {
            cell.gifBg.animate(withGIFNamed: "snow")
        } else if cell.descrLabel.text == WeatherConditions.snow.rawValue  {
            cell.gifBg.animate(withGIFNamed: "snowNight")
        } else if cell.descrLabel.text == WeatherConditions.clouds.rawValue && dayHour.contains(localHour) {
            cell.gifBg.animate(withGIFNamed: "clouds")
        } else if  cell.descrLabel.text == WeatherConditions.clouds.rawValue  {
            cell.gifBg.animate(withGIFNamed: "cloudsNight")
        } else if cell.descrLabel.text == WeatherConditions.clearsky.rawValue && dayHour.contains(localHour) {
            cell.gifBg.animate(withGIFNamed: "clearsky")
        } else if cell.descrLabel.text == WeatherConditions.clearsky.rawValue  {
            cell.gifBg.animate(withGIFNamed: "clearskyNight")
        } else if cell.descrLabel.text == WeatherConditions.thunerstorm.rawValue {
            cell.gifBg.animate(withGIFNamed: "thunderstorm")
        }  else if cell.descrLabel.text == WeatherConditions.drizzle.rawValue {
            cell.gifBg.animate(withGIFNamed: "drizzle")
        } else {
            cell.backgroundColor = .black
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailVC()
        vc.detailView.cityName.text = self.cities[indexPath.row].name
        vc.detailView.tempLabel.text = "\(Int(self.cities[indexPath.row].main.temp - 273))°"
        vc.detailView.feelsLikeLabel.text = "Feels like \(Int(self.cities[indexPath.row].main.feelsLike - 273))°"
        vc.detailView.descLabel.text = self.cities[indexPath.row].weather.first?.description
        vc.detailView.windSpeedlabel.text = "Wind: \(self.cities[indexPath.row].wind.speed) m/s"
        let doubleTz = Double(self.cities[indexPath.row].timezone)
        let localHour = TimeWorker.getCurrentTime(time: doubleTz)
        let currentTime = TimeWorker.getFormattedLocalTime(time: doubleTz)
        vc.detailView.localTimeLabel.text = "Local time \(currentTime)"
        if self.cities[indexPath.row].weather.first?.main == WeatherConditions.clouds.rawValue && dayHour.contains(localHour) {
            vc.detailView.gifBg.animate(withGIFNamed: "clouds")
        } else if self.cities[indexPath.row].weather.first?.main == WeatherConditions.clouds.rawValue {
            vc.detailView.gifBg.animate(withGIFNamed: "cloudsNight")
        } else if self.cities[indexPath.row].weather.first?.main == WeatherConditions.snow.rawValue && dayHour.contains(localHour) {
            vc.detailView.gifBg.animate(withGIFNamed: "snow")
        } else if self.cities[indexPath.row].weather.first?.main == WeatherConditions.snow.rawValue  {
            vc.detailView.gifBg.animate(withGIFNamed: "snowNight")
        } else if self.cities[indexPath.row].weather.first?.main == WeatherConditions.rain.rawValue && dayHour.contains(localHour) {
            vc.detailView.cityName.textColor = .black
            vc.detailView.feelsLikeLabel.textColor = .black
            vc.detailView.tempLabel.textColor = .black
            vc.detailView.borderActivityLabel.textColor = .black
            vc.detailView.descLabel.textColor = .black
            vc.detailView.windSpeedlabel.textColor = .black
            vc.detailView.gifBg.animate(withGIFNamed: "rain")
        } else if self.cities[indexPath.row].weather.first?.main == WeatherConditions.rain.rawValue {
            vc.detailView.gifBg.animate(withGIFNamed: "rainNight")
        } else if self.cities[indexPath.row].weather.first?.main == WeatherConditions.clearsky.rawValue && dayHour.contains(localHour) {
            vc.detailView.gifBg.animate(withGIFNamed: "clearsky")
        } else if self.cities[indexPath.row].weather.first?.main == WeatherConditions.clearsky.rawValue {
            vc.detailView.gifBg.animate(withGIFNamed: "clearskyNight")
        } else if self.cities[indexPath.row].weather.first?.main == WeatherConditions.thunerstorm.rawValue {
            vc.detailView.gifBg.animate(withGIFNamed: "thunderstorm")
        } else if self.cities[indexPath.row].weather.first?.main == WeatherConditions.drizzle.rawValue{
            vc.detailView.gifBg.animate(withGIFNamed: "drizzle")
        } else {
            vc.detailView.backgroundColor = .black
        }
        self.present(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: nil) { _, _, _ in
            var arrayDefault = self.userDefaults.stringArray(forKey: "Citiarray")
            arrayDefault?.remove(at: indexPath.row)
            self.userDefaults.set(arrayDefault, forKey: "Citiarray")
            self.cities.remove(at: indexPath.row)
            self.playSound(resource: "deleteSound")
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
        let circleDiameter = max(size.width * 1.3, size.height * 1.3)
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

extension MainViewVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            let filteredCities = self.cities.filter({$0.name.contains(searchText)})
            self.cities = filteredCities
            mainView.table.reloadData()
        } else {
            self.cities.removeAll()
            let citiarray = self.userDefaults.stringArray(forKey: "Citiarray")
            for citi in citiarray! {
                NetworkService.getLatLon(city: citi) { latlon in
                    NetworkService.getWeather(latitude: latlon.first!.lat, longitute: latlon.first!.lon) { weather in
                        let weatherS = WeatherData(weather: weather.weather, main: weather.main, wind: weather.wind, name: latlon.first!.name, timezone: weather.timezone, id: weather.id)
                        DispatchQueue.main.async {
                            self.cities.append(weatherS)
                            self.mainView.table.reloadData()
                        }
                    }
                }
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
    }
      
    

}





