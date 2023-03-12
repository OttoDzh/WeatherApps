//
//  DetailView.swift
//  WeatherApps
//
//  Created by Otto Dzhandzhuliya on 09.03.2023.
//

import UIKit

class DetailView: UIView {
    
    let table = UITableView()
    let cityName = UILabel(text: "CityName", font: ODFonts.titleLabelFont)
    let tempLabel = UILabel(text: "temp", font: ODFonts.boldTextFont)
    let cloudyLabel = UILabel(text: "Cloudy", font: ODFonts.boldTextFont)
    
    init() {
        super.init(frame: CGRect())
        
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        table.register(DetailCell.self, forCellReuseIdentifier: DetailCell.reuseId)
        table.layer.cornerRadius = 6
        table.backgroundColor = .black
        backgroundColor = .black
        cityName.textColor = .white
        tempLabel.textColor = .white
        tempLabel.font = UIFont(name: "AppleSDGothicNeo-bold", size: 48)
        cloudyLabel.textColor = .white
       
        
    }
    func setupConstraints() {
        
        addSubview(table)
        addSubview(cityName)
        addSubview(tempLabel)
        addSubview(cloudyLabel)
       
        
        Helper.tamicOff(views: [table,cityName,tempLabel,cloudyLabel])
        
        NSLayoutConstraint.activate([table.topAnchor.constraint(equalTo: topAnchor, constant: 250),
                                     table.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                                     table.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                                     table.bottomAnchor.constraint(equalTo: bottomAnchor),
                                     cityName.topAnchor.constraint(equalTo: topAnchor, constant: 50),
                                     cityName.centerXAnchor.constraint(equalTo: centerXAnchor),
                                     tempLabel.topAnchor.constraint(equalTo: cityName.bottomAnchor, constant: 25),
                                     tempLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                                     cloudyLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 10),
                                     cloudyLabel.centerXAnchor.constraint(equalTo: centerXAnchor)])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  
}
