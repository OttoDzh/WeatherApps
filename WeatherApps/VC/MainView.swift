//
//  MainView.swift
//  Weather
//
//  Created by Otto Dzhandzhuliya on 08.03.2023.
//

import UIKit

class MainView: UIView {

    let weatherLabel = UILabel(text: "Weather", font: ODFonts.titleLabelFont)
    let addCityButton = UIButton(title: "AddCity", bgColor: .black, textColor: .white, font: ODFonts.avenirFont, cornerRadius: 12)
    let table = UITableView()

    init() {
        super.init(frame: CGRect())
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        table.register(MyCell.self, forCellReuseIdentifier: MyCell.reuseId)
        table.layer.cornerRadius = 6
        table.backgroundColor = .black
        table.separatorStyle = .none
        backgroundColor = .black
        weatherLabel.textColor = .white
        table.separatorStyle = .singleLine
    }
    func setupConstraints() {
        addSubview(table)
        addSubview(weatherLabel)
        addSubview(addCityButton)
        Helper.tamicOff(views: [table,weatherLabel,addCityButton])
        NSLayoutConstraint.activate([table.topAnchor.constraint(equalTo: topAnchor, constant: 150),
                                     table.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                                     table.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                                     table.bottomAnchor.constraint(equalTo: bottomAnchor),
                                     weatherLabel.topAnchor.constraint(equalTo: topAnchor, constant: 48),
                                     weatherLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
                                     addCityButton.topAnchor.constraint(equalTo: topAnchor, constant: 48),
                                     addCityButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
