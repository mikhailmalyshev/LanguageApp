//
//  DictionaryViewController.swift
//  LanguageApp
//
//  Created by Михаил Малышев on 06/04/2020.
//  Copyright © 2020 Mikhail Malyshev. All rights reserved.
//

import UIKit
import RealmSwift

class DictionaryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    var words: Results<Word>!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var dictionaryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        words = realm.objects(Word.self)
        
        dictionaryTableView.delegate = self
        dictionaryTableView.dataSource = self
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           dictionaryTableView.reloadData()
       }

//    кнопка добавления слова в словарь
    
    @IBAction func findAndAddWordButton() {
        NetworkManager.shared.getTranslate(text: searchBar.text ?? "wrong", lang: "en-ru") { translation in
            guard let translation = translation else { return }
            DispatchQueue.main.async {
                let word = Word()
                word.word = self.searchBar.text ?? "error"
                word.translate = translation.text[0]
                StorageManager.shared.add(word: word)
                let rowIndex = IndexPath(row: self.words.count - 1, section: 0)
                self.dictionaryTableView.insertRows(at: [rowIndex], with: .automatic)
            }
        }
        
    }

//    конфигурируем таблицу
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dictionary", for: indexPath)
        let word = words[indexPath.row]
        cell.textLabel?.text = word.word
        cell.detailTextLabel?.text = word.translate
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let word = words[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .destructive, title: "delete") { (_, _, _) in
            StorageManager.shared.delete(word: word)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
