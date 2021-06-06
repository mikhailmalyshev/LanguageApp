//
//  Model.swift
//  LanguageApp
//
//  Created by Михаил Малышев on 05/04/2020.
//  Copyright © 2020 Mikhail Malyshev. All rights reserved.
//

import RealmSwift

class Word: Object {
    @objc dynamic var id = ""
    @objc dynamic var word = ""
    @objc dynamic var translate = ""
    @objc dynamic var image = ""
    @objc dynamic var isLearn = false
    @objc dynamic var setId = 0
    @objc dynamic var date = Date()
}

class WordList: Object {
    let words = List<Word>()
}

struct Translation: Codable {
    let translatedText: String
}
