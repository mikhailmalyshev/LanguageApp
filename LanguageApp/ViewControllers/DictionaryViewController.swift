//
//  DictionaryViewController.swift
//  LanguageApp
//
//  Created by Михаил Малышев on 06/04/2020.
//  Copyright © 2020 Mikhail Malyshev. All rights reserved.
//

import UIKit

class DictionaryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var words = WordWithTranslate.getDictionary()
    
    @IBOutlet weak var dictionaryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dictionaryTableView.delegate = self
        dictionaryTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dictionary", for: indexPath)
        let word = words[indexPath.row]
        cell.textLabel?.text = word.word
        cell.detailTextLabel?.text = word.translation
        return cell
    }
}
