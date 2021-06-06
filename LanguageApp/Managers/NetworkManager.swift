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
    
    func getTranslate(text: String, lang: String? = nil, completion: @escaping (Translation?) -> Void) {
        
        let headers = [
            "content-type": "application/json",
            "x-rapidapi-key": "fb5163cc14msh047bcdd9e5685efp1b342fjsn731fab699046",
            "x-rapidapi-host": "language-translation.p.rapidapi.com"
        ]
        let parameters = [
            "target": "ru",
            "text": text,
            "type": "plain"
        ] as [String : Any]

        let postData = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        let request = NSMutableURLRequest(url: NSURL(string: "https://language-translation.p.rapidapi.com/translateLanguage/translate")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
        
        
        URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
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
