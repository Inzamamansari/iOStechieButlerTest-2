//
//  APIManager.swift
//  iOStechieButlerTest
//
//  Created by Inzimamul Ansari on 30/04/24.
//

import Foundation

class APIManager {
    static let shared = APIManager()
    
    private init() {}
    
    func fetchPosts(page: Int, limit: Int, completion: @escaping ([Post]?, Error?) -> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts?_page=\(page)&_limit=\(limit)") else {
            completion(nil, NSError(domain: "Invalid URL", code: 0, userInfo: nil))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(nil, NSError(domain: "Invalid response", code: 0, userInfo: nil))
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "No data received", code: 0, userInfo: nil))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode([Post].self, from: data)
                completion(decodedData, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}
