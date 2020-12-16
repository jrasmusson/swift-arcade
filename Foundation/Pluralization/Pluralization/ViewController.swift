//
//  ViewController.swift
//  Localization
//
//  Created by jrasmusson on 2020-12-16.
//

import UIKit

class ViewController: UIViewController {

    let stackView = UIStackView()
    let picker = UIPickerView()
    let label = UILabel()
    
    let days = [0, 1, 2, 3]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension ViewController {
    
    func style() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        
        picker.translatesAutoresizingMaskIntoConstraints = false
        self.picker.delegate = self
        self.picker.dataSource = self
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = String.localizedStringWithFormat(NSLocalizedString("overdue", comment: "Overdue warning message"), 0)
        
        //        label.text = NSLocalizedString("overdue", comment: "Overdue warning message") // regular localized string
    }
    
    func layout() {
        stackView.addArrangedSubview(picker)
        stackView.addArrangedSubview(label)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            view.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            view.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
        ])
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return days.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(days[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let localized = NSLocalizedString("overdue", comment: "xxx")
        let formatted = String(format: localized, days[row])
        label.text = formatted
        print(formatted)
    }
}
