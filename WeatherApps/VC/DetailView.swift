//
//  DetailView.swift
//  WeatherApps
//
//  Created by Otto Dzhandzhuliya on 09.03.2023.
//

import UIKit
import Gifu

class DetailView: UIView {

    let cityName = UILabel(text: "CityName", font: ODFonts.titleLabelFont)
    let tempLabel = UILabel(text: "temp", font: ODFonts.boldTextFont)
    let feelsLikeLabel = UILabel(text: "Feels like", font: ODFonts.avenirFont)
    let borderActivityLabel = UILabel(text: "", font: ODFonts.titleLabelFont)
    let descLabel = UILabel(text: "", font: ODFonts.avenirFont)
    let windSpeedlabel = UILabel(text: "", font: ODFonts.avenirFont)
    let gifBg = GIFImageView()
    let localTimeLabel = UILabel(text: "Local time 14:54", font: ODFonts.avenirFont)
    
    init() {
        super.init(frame: CGRect())
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        cityName.textColor = .white
        tempLabel.textColor = .white
        tempLabel.font = UIFont(name: "AppleSDGothicNeo-bold", size: 48)
        gifBg.contentMode = .scaleAspectFill
        feelsLikeLabel.textColor = .white
        borderActivityLabel.textColor = .white
        borderActivityLabel.textAlignment = .center
        borderActivityLabel.lineBreakMode = .byWordWrapping
        borderActivityLabel.numberOfLines = 12
        descLabel.textColor = .white
        descLabel.textAlignment = .center
        descLabel.lineBreakMode = .byWordWrapping
        descLabel.numberOfLines = 12
        windSpeedlabel.numberOfLines = 2
        windSpeedlabel.textColor = .white
        localTimeLabel.textColor = .white
    }
    func setupConstraints() {
        
        addSubview(gifBg)
        addSubview(cityName)
        addSubview(tempLabel)
        addSubview(feelsLikeLabel)
        addSubview(borderActivityLabel)
        addSubview(descLabel)
        addSubview(windSpeedlabel)
        addSubview(localTimeLabel)
        Helper.tamicOff(views: [cityName,tempLabel,gifBg,feelsLikeLabel,borderActivityLabel,descLabel,windSpeedlabel,localTimeLabel])
        
        NSLayoutConstraint.activate([
                                     cityName.topAnchor.constraint(equalTo: topAnchor, constant: 50),
                                     cityName.centerXAnchor.constraint(equalTo: centerXAnchor),
                                     tempLabel.topAnchor.constraint(equalTo: cityName.bottomAnchor, constant: 25),
                                     tempLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                                     feelsLikeLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 5),
                                     feelsLikeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                                     gifBg.topAnchor.constraint(equalTo: topAnchor),
                                     gifBg.bottomAnchor.constraint(equalTo: bottomAnchor),
                                     gifBg.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     gifBg.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     borderActivityLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                                     borderActivityLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
                                     borderActivityLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
                                     borderActivityLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
                                     borderActivityLabel.heightAnchor.constraint(equalToConstant: 300),
                                     descLabel.topAnchor.constraint(equalTo: feelsLikeLabel.bottomAnchor, constant: 12),
                                     descLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                                     windSpeedlabel.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 12),
                                     windSpeedlabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                                     localTimeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
                                     localTimeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24)])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
