//
//  NetworkManager.swift
//  LanguageApp
//
//  Created by Михаил Малышев on 19/04/2020.
//  Copyright © 2020 Mikhail Malyshev. All rights reserved.
//

import Foundation

let key = "trnsl.1.1.20200418T101725Z.2c3fad2204783f29.b99a677e55c8d8adaf132b1780846626a6599586"
let translateUrl = "https://translate.yandex.net/api/v1.5/tr.json/translate"

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func getTranslate(text: String, lang: String, completion: @escaping (Translation?) -> Void) {
        guard let url = URL(string: "https://translate.yandex.net/api/v1.5/tr.json/translate?key=\(key)&text=\(text)&lang=\(lang)&format=plain&options=1") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                print("first error")
                completion(nil)
                return
            }
            
            guard let data = data else {
                completion(nil)
                return
            }

            do {
                let translation = try JSONDecoder().decode(Translation.self, from: data)
                completion(translation)
            } catch {
                print(error)
                print("second error")
                completion(nil)
            }
        }.resume()
    }
}
