//
//  WordManager.swift
//  LanguageApp
//
//  Created by Михаил Малышев on 06/04/2020.
//  Copyright © 2020 Mikhail Malyshev. All rights reserved.
//

import RealmSwift
let realm = try! Realm()

class StorageManager {
    
    static let shared = StorageManager()
    
    private init() {}
    
    func add(word: Word) {
        write {
            realm.add(word)
        }
    }
    
    func delete(word: Word) {
        write {
            realm.delete(word)
        }
    }
    
    func done(word: Word) {
        write {
            word.setValue(true, forKey: "isLearn")
        }
    }
    
    private func write(_ completion: () -> Void) {
        do {
            try realm.write {
                completion()
            }
        } catch let error {
            print(error)
        }
    }
}
