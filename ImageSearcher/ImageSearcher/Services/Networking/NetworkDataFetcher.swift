//
//  NetworkDataFetcher.swift
//  testFlickr
//
//  Created by Kyzu on 29.11.22.
//

import Foundation

class NetworkDataFetcher {
   
    var networkService = NetworkService()
    
    func fetchImages(searchTags: String, sortBy: String, pageNumber: Int, completion: @escaping (SearchResults?) -> ()) {
        networkService.request(searchTags: searchTags, sortBy: sortBy, pageNumber: pageNumber) { (data, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            }
           
            let decode = self.decodeJSON(type: SearchResults.self, from: data)
            completion(decode)
        }
    }
    
    func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        
        do {
            let objects = try decoder.decode(type.self, from: data)
            print(objects)
            return objects
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
