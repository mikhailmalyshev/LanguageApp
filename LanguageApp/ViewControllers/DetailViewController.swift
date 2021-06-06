//
//  DetailViewController.swift
//  LanguageApp
//
//  Created by Михаил Малышев on 26/04/2020.
//  Copyright © 2020 Mikhail Malyshev. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var word = Word()
    
    
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var translateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wordLabel.text = word.word
        translateLabel.text = word.translate
    }
    
}
