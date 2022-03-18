//
//  ViewController.swift
//  LanguageApp
//
//  Created by Михаил Малышев on 01/04/2020.
//  Copyright © 2020 Mikhail Malyshev. All rights reserved.
//

import UIKit
import RealmSwift

class TeachViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let realm = try! Realm()
    private lazy var words: Results<Word> = { self.realm.objects(Word.self) }()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let firstSectionCell = tableView.dequeueReusableCell(withIdentifier: "firstSectionCell", for: indexPath)
            
            firstSectionCell.textLabel?.text = "\(words.count) слов"
            firstSectionCell.textLabel?.font = UIFont.systemFont(ofSize: 20)
            firstSectionCell.indentationLevel = 12
            firstSectionCell.detailTextLabel?.text = "\(words.filter("isLearn == true").count) выучено"
            firstSectionCell.detailTextLabel?.font = UIFont.systemFont(ofSize: 20)
            
            return firstSectionCell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "secondSectionCell", for: indexPath)
            return cell
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let label = UILabel()
        label.text = section == 0 ? "Основной словарь" : "Наборы слов"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.backgroundColor = .gray
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 100
        } else {
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

