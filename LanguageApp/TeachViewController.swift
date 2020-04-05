//
//  ViewController.swift
//  LanguageApp
//
//  Created by Михаил Малышев on 01/04/2020.
//  Copyright © 2020 Mikhail Malyshev. All rights reserved.
//

import UIKit

class TeachViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
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
            
            firstSectionCell.textLabel?.text = "0 слов"
            firstSectionCell.textLabel?.font = UIFont.systemFont(ofSize: 20)

            firstSectionCell.detailTextLabel?.text = "0 выучено"
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
        if section == 0 {
            label.text = "Основной словарь"
        } else {
            label.text = "Наборы слов"
        }
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
}


//extension TeachViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if tableView == firstTableView {
//            return 1
//        } else {
//            return 10
//        }
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if tableView == firstTableView {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "firstTableViewCell", for: indexPath)
//            cell.textLabel?.text = "0 слов"
//            cell.detailTextLabel?.text = "0 выучено"
//            return cell
//        } else {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "secondTableViewCell", for: indexPath)
//            return cell
//        }
//    }
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if tableView == firstTableView {
//            return "Основной словарь"
//        } else {
//            return "Наборы слов"
//        }
//    }
//
//
//}

