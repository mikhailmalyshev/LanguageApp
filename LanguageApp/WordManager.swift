//
//  WordManager.swift
//  LanguageApp
//
//  Created by Михаил Малышев on 06/04/2020.
//  Copyright © 2020 Mikhail Malyshev. All rights reserved.
//

class WordManager {
    
    static let shared = WordManager()
    
    private init() {}
    
    let wordWithTranslate = ["hi" : "привет", "bye" : "пока"]
    
}
