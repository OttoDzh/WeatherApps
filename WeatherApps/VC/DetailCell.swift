//
//  DetailCell.swift
//  WeatherApps
//
//  Created by Otto Dzhandzhuliya on 10.03.2023.
//

import UIKit

class DetailCell: UITableViewCell {
 
        static let reuseId = "DetailCell"
        
        let cityName = UILabel(text: "City name", font: ODFonts.boldTextFont)
        let tempLabbel = UILabel(text: "10 °", font: ODFonts.titleLabelFont)
        let descrLabel = UILabel(text: "", font: ODFonts.regulatTextFont)
        let minTempLabel = UILabel(text: "", font: ODFonts.avenirFont)
        let maxTempLabel = UILabel(text: "", font: ODFonts.avenirFont)

        

        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: MyCell.reuseId)
            
            backgroundColor = .black
            
           let whiteArray = [cityName,tempLabbel,descrLabel,minTempLabel,maxTempLabel]
            for i in whiteArray {
                i.textColor = .white
            }
            
            let minMaxStack = UIStackView(arrangedSubviews: [maxTempLabel,minTempLabel], axis: .horizontal, spacing: 6)
            
            addSubview(cityName)
            addSubview(tempLabbel)
            addSubview(descrLabel)
            addSubview(minMaxStack)
            
            Helper.tamicOff(views: [cityName,tempLabbel,descrLabel,minMaxStack])
            
          
            
            
            NSLayoutConstraint.activate([cityName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
                                         cityName.topAnchor.constraint(equalTo: topAnchor,constant: 4),
                                         descrLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
                                         descrLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
                                         tempLabbel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
                                         tempLabbel.topAnchor.constraint(equalTo: topAnchor, constant: 4),
                                         minMaxStack.trailingAnchor.constraint(equalTo: trailingAnchor , constant: -12),
                                         minMaxStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)])
            
            NSLayoutConstraint.activate([])
            
            
            
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }



