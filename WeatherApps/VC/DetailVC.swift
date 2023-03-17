//
//  DetailVC.swift
//  WeatherApps
//
//  Created by Otto Dzhandzhuliya on 09.03.2023.
//

import UIKit
import Gifu


class DetailVC: UIViewController {
    
    let detailView = DetailView()
    let time = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = detailView
        NetworkService.getInfoDate { border in
            DispatchQueue.main.async {
                self.detailView.borderActivityLabel.text = "Here is some activity for you: \(border.activity)"
            }
          
        }

    }
}

