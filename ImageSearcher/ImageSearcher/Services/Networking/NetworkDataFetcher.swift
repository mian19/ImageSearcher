//
//  NetworkDataFetcher.swift
//  testFlickr
//
//  Created by Kyzu on 29.11.22.
//

import Foundation
import UIKit

class NetworkDataFetcher {
   
    var networkService = NetworkService()
    var imageCach = NSCache<NSString, UIImage>()
    
    func fetchImages(searchTags: String, sortBy: String, pageNumber: Int, completion: @escaping (SearchResults?) -> ()) {
        networkService.request(searchTags: searchTags, sortBy: sortBy, pageNumber: pageNumber) { (data, error) in
            if let error = error {
                print(error)
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
            print(error)
            return nil
        }
    }
    
    func getImage(url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        
        if let cachedImage = imageCach.object(forKey: url.absoluteString as NSString) {
            completion(.success(cachedImage))
        } else {
            
            let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 1)
            
            URLSession.shared.dataTask(with: request) {(data, _, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    print("Empty data")
                    return
                }
                
                guard let image = UIImage(data: data) else { return }
                self.imageCach.setObject(image, forKey: url.absoluteString as NSString)
                
                DispatchQueue.main.async {
                    completion(.success(image))
                }
                
            }.resume()
        }
    }
    
    
    
}
