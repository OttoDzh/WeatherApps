//
//  ViewSettings.swift
//  KitU
//
//  Created by Otto Dzhandzhuliya on 16.01.2023.
//

//class CheckView: UIView {
//
//    init() {
//        super.init(frame: CGRect())
//
//        setupViews()
//        setupConstraints()
//    }
//
//
//
//
//
//    func setupViews() {
//        backgroundColor = .orange
//    }
//
//    func setupConstraints() {
//
//    }
//
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//  guard let scene = (scene as? UIWindowScene) else { return }
//  window = UIWindow(windowScene: scene)
//  window?.rootViewController = CheckViewController()
//  window?.makeKeyAndVisible()
//}

//let alertController = UIAlertController(title: "Error!", message: "Enter positive numeric value", preferredStyle: .alert)
//let action = UIAlertAction(title: "Ок", style: .default) {(action) in
//}
//alertController.addAction(action)
//self.present(alertController, animated: true)
//

//func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//
//    let aSet = NSCharacterSet(charactersIn:".0123456789").inverted    // and tf.delegate = self
//    let compSepByCharInSet = string.components(separatedBy: aSet)
//    let numberFiltered = compSepByCharInSet.joined(separator: "")
//    return string == numberFiltered
//}
//

//func textFieldShouldReturn(_ textField: UITextField) -> Bool {   // and tf.delegate = self
//    self.view.endEditing(true)
//    return false
//}

// in viewdidload:
// let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
//mainView.addGestureRecognizer(tap)

// in code:
//   @objc func hideKeyboard() {
//view.endEditing(true)
//}


// in view: for placeholdertext
//let pcForDays = NSAttributedString(string: "Deposit term/days",attributes: [NSAttributedString.Key.foregroundColor:UIColor.darkGray])
//days.attributedPlaceholder = pcForDays
//
// opacity for color: 65%

// ALERT WITH TF:
//       let alertController = UIAlertController(title: "AddCity!", message: "Enter city name", preferredStyle: .alert)
//        alertController.addTextField {(textfield: UITextField!) -> Void in
//            textfield.placeholder = "City name"
//        }
//        let saveAction = UIAlertAction(title: "Add", style: .default, handler: { alert -> Void in
//            let firsTexField = alertController.textFields![0] as UITextField
//            firsTexField.translatesAutoresizingMaskIntoConstraints = false
//            print("City name: \(firsTexField)")
//            guard let cityname = firsTexField.text else {return}
//            self.array.append(cityname)
//            NetworkService.getLatLon(city: cityname) { latlon in
//                DispatchQueue.main.async {
//                    self.mainView.pickerView.reloadAllComponents()
//                    let selectedRow = self.mainView.pickerView.selectedRow(inComponent: 0)
//                    if selectedRow == 6 {
//                        self.getWeatherNow(latitude: latlon.first!.lat, longitude: latlon.first!.lon)
//                    }
//
//                }
//
//            }
//
//        })
//
//        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
//        alertController.addAction(saveAction)
//        alertController.addAction(cancelAction)
//
//        self.present(alertController, animated: true)
//
