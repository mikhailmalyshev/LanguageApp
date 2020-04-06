//
//  Model.swift
//  LanguageApp
//
//  Created by Михаил Малышев on 05/04/2020.
//  Copyright © 2020 Mikhail Malyshev. All rights reserved.
//

struct WordWithTranslate {
    let word: String?
    let translation: String?
    
    static func getDictionary() -> [WordWithTranslate] {
        var words: [WordWithTranslate] = []
        let wordsWithTranslate = WordManager.shared.wordWithTranslate
        for (word,translate) in wordsWithTranslate {
            words.append(WordWithTranslate(word: word, translation: translate))
        }
        return words
    }
}
