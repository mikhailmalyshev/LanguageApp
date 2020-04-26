//
//  DictionaryViewController.swift
//  LanguageApp
//
//  Created by Михаил Малышев on 06/04/2020.
//  Copyright © 2020 Mikhail Malyshev. All rights reserved.
//

import UIKit
import RealmSwift

class DictionaryViewController: UIViewController {
    
    //MARK: Priavte properties
    
    private var searchController: UISearchController!
    private var words: Results<Word>!
    private var searchResults = try! Realm().objects(Word.self)
    
    //MARK: IBOutlets
    
    @IBOutlet weak var dictionaryTableView: UITableView!
    @IBOutlet weak var searchControllerContainerView: UIView!
    
    //MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchControllerContainerView.addSubview(searchController.searchBar)
    
        words = realm.objects(Word.self)
        
        dictionaryTableView.delegate = self
        dictionaryTableView.dataSource = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
    }
      
    //MARK: IBActions
    
    @IBAction func findAndAddWordButton() {
        NetworkManager.shared.getTranslate(text: searchController.searchBar.text ?? "wrong", lang: "en-ru") { translation in
            guard let translation = translation else { return }
            DispatchQueue.main.async {
                let word = Word()
                word.word = self.searchController.searchBar.text ?? "error"
                word.translate = translation.text[0]
                StorageManager.shared.add(word: word)
                var rowIndex = IndexPath(row: 0, section: 0)
                if self.searchController.isActive {
                    rowIndex = IndexPath(row: self.searchResults.count - 1, section: 0)
                } else {
                    rowIndex = IndexPath(row: self.words.count - 1, section: 0)
                }
                self.dictionaryTableView.insertRows(at: [rowIndex], with: .automatic)
            }
        }
        
    }
}

//MARK: TableVIew

extension DictionaryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            return searchResults.count
        } else {
            return words.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dictionary", for: indexPath)
        
        let word = searchController.isActive ?
            searchResults[indexPath.row] : words[indexPath.row]
        cell.textLabel?.text = word.word
        cell.detailTextLabel?.text = word.translate
        cell.imageView?.image = UIImage(systemName: "tag")
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let word = words[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .destructive, title: "delete") { (_, _, _) in
            StorageManager.shared.delete(word: word)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        deleteAction.backgroundColor = .darkGray
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

//MARK: Work with search

extension DictionaryViewController: UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating {
    
    func filterResultsWithSearchString(searchString: String) {
        let predicate = NSPredicate(format: "word BEGINSWITH [c]%@", searchString) // 1
        let realm = try! Realm()
        searchResults = realm.objects(Word.self).filter(predicate).sorted(byKeyPath: "word", ascending: true) // 3
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchString = searchController.searchBar.text!
        filterResultsWithSearchString(searchString: searchString)
        dictionaryTableView.reloadData()
    }
}
