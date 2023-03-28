//
//  MainView.swift
//  Weather
//
//  Created by Otto Dzhandzhuliya on 08.03.2023.
//

import UIKit

class MainView: UIView {
    let weatherLabel = UILabel(text: "Weather", font: ODFonts.titleLabelFont)
    let searchBar = UISearchBar()
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
        weatherLabel.layer.cornerRadius = 15
        table.separatorStyle = .singleLine
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = true
        searchBar.backgroundColor = .clear
        searchBar.backgroundImage = UIImage()
        searchBar.tintColor = .white
        searchBar.layer.cornerRadius = 12
        searchBar.searchTextField.textColor = .white
    }
    func setupConstraints() {
        addSubview(table)
        addSubview(weatherLabel)
        
        addSubview(searchBar)
        Helper.tamicOff(views: [table,weatherLabel,searchBar])
        NSLayoutConstraint.activate([table.topAnchor.constraint(equalTo: topAnchor, constant: 150),
                                     table.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                                     table.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                                     table.bottomAnchor.constraint(equalTo: bottomAnchor),
                                     weatherLabel.topAnchor.constraint(equalTo: topAnchor, constant: 48),
                                     weatherLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
                                     weatherLabel.widthAnchor.constraint(equalToConstant: 350),
                                     weatherLabel.heightAnchor.constraint(equalToConstant: 50),
                                     searchBar.topAnchor.constraint(equalTo: weatherLabel.bottomAnchor, constant: 8),
                                     searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
                                     searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
                                     searchBar.heightAnchor.constraint(equalToConstant: 40)])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
