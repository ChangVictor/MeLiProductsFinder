//
//  Service.swift
//  MeLiProductsFinder
//
//  Created by Victor Chang on 22/10/2019.
//  Copyright © 2019 Victor Chang. All rights reserved.
//

import Foundation

class Service {
    
    static let shared = Service()
    
    func fetchJSONData<T: Decodable>(urlString: URL, completion: @escaping (T?, Error?) -> ()) {
        
        URLSession.shared.dataTask(with: urlString) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                    return
            }
            do {
                guard let data = data else { return }
                let object = try JSONDecoder().decode(T.self, from: data)
                completion(object, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}

extension Service {
    
    func fetchItems(searchTerm: String?, completion: @escaping (SearchResult?, Error?) -> () ) {
            
        var components = URLComponents()
            components.scheme = "https"
            components.host = "api.mercadolibre.com"
            components.path = "/sites/MLA/search"
            components.queryItems = [
                URLQueryItem(name: "q", value: searchTerm),
                URLQueryItem(name: "offset", value: "0"),
                URLQueryItem(name: "limit", value: "20")
            ]
            guard let url = components.url else { return }
            Logger.print("Fetching items from: \(url)")
            fetchJSONData(urlString: url, completion: completion)
        }
}
