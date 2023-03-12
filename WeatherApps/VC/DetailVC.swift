//
//  DetailVC.swift
//  WeatherApps
//
//  Created by Otto Dzhandzhuliya on 09.03.2023.
//

import UIKit

class DetailVC: UIViewController {
    
    let detailView = DetailView()
    var listArray = [List]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = detailView
        detailView.table.delegate = self
        detailView.table.dataSource = self
        
        
        NetworkService.getLatLon(city: "Moscow") { latlon in
            DispatchQueue.main.async {
                
                NetworkService.getWeatherForFiveDays(latitude: latlon.first!.lat, longitute: latlon.first!.lon) { weatherFiveDays in
                    self.listArray = weatherFiveDays.list
                    DispatchQueue.main.async {
                        self.detailView.table.reloadData()
                    }
                }
            }
        }
    }
}

extension DetailVC: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailCell.reuseId, for: indexPath) as! DetailCell
        let deg = listArray[indexPath.row]
        cell.tempLabbel.text = "\(Int(deg.main.temp - 273))°"
        cell.cityName.text = deg.dt_txt
        
       return cell
    }
    
    
}
