//
//  LanguageViewController.swift
//  LanguageApp
//
//  Created by Михаил Малышев on 01/04/2020.
//  Copyright © 2020 Mikhail Malyshev. All rights reserved.
//

import UIKit

class LanguageViewController: UIViewController {
    
    
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var languagePickerView: UIPickerView!
    
    private var languages = ["English", "Deutsch", "French", "Spanish"]

    override func viewDidLoad() {
        super.viewDidLoad()
        languagePickerView.delegate = self
        languagePickerView.dataSource = self
    }
}

extension LanguageViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        languages.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        languages[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        languageLabel.text = "Language selected: \(languages[row])"
    }
    
}
