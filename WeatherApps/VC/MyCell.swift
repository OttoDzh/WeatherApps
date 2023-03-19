//
//  MyCell.swift
//  Weather
//
//  Created by Otto Dzhandzhuliya on 08.03.2023.
//

import UIKit
import Gifu

class MyCell: UITableViewCell {

    static let reuseId = "TaskTableCell"
    var gifBg = GIFImageView()
    let cityName = UILabel(text: "City name", font: ODFonts.boldTextFont)
    let tempLabbel = UILabel(text: "10 °", font: ODFonts.titleLabelFont)
    let descrLabel = UILabel(text: "Cloudly", font: ODFonts.regulatTextFont)
    let minTempLabel = UILabel(text: "L:9°", font: ODFonts.avenirFont)
    let maxTempLabel = UILabel(text: "H:13°", font: ODFonts.avenirFont)
    let localTimeLabel = UILabel(text: "14:20", font: ODFonts.avenirFont)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: MyCell.reuseId)
        backgroundColor = .black
       let whiteArray = [cityName,tempLabbel,descrLabel,minTempLabel,maxTempLabel,localTimeLabel]
        for i in whiteArray {
            i.textColor = .white
        }
        let minMaxStack = UIStackView(arrangedSubviews: [maxTempLabel,minTempLabel], axis: .horizontal, spacing: 6)
        gifBg.layer.cornerRadius = 15
        gifBg.clipsToBounds = true
        gifBg.contentMode = .scaleAspectFill
        addSubview(gifBg)
        addSubview(cityName)
        addSubview(tempLabbel)
        addSubview(descrLabel)
        addSubview(minMaxStack)
        addSubview(localTimeLabel)
        minTempLabel.font = UIFont(name: "AvenirNext-BOLD", size: 12)
        maxTempLabel.font = UIFont(name: "AvenirNext-BOLD", size: 12)
        Helper.tamicOff(views: [cityName,tempLabbel,descrLabel,minMaxStack,gifBg,localTimeLabel])
        NSLayoutConstraint.activate([cityName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
                                     cityName.topAnchor.constraint(equalTo: topAnchor,constant: 4),
                                     localTimeLabel.topAnchor.constraint(equalTo: cityName.bottomAnchor, constant: 4),
                                     localTimeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
                                     descrLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
                                     descrLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
                                     tempLabbel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
                                     tempLabbel.topAnchor.constraint(equalTo: topAnchor, constant: 4),
                                     minMaxStack.trailingAnchor.constraint(equalTo: trailingAnchor , constant: -12),
                                     minMaxStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
                                     gifBg.topAnchor.constraint(equalTo: topAnchor),
                                     gifBg.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     gifBg.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     gifBg.bottomAnchor.constraint(equalTo: bottomAnchor)])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
