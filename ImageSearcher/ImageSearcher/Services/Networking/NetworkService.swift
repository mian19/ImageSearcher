//
//  NetworkService.swift
//  testFlickr
//
//  Created by Kyzu on 29.11.22.
//

import Foundation

class NetworkService {

    func request(searchTags: String, sortBy: String = "relevance", pageNumber: Int, completion: @escaping (Data?, Error?) -> Void ) {
        let parameters = self.prepareParameters(searchTags: searchTags, sortBy: sortBy, pageNumber: pageNumber)
        let url = self.url(params: parameters)
        print(url)
        var request = URLRequest(url: url)
        request.httpMethod = "get"
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func prepareParameters(searchTags: String, sortBy: String , pageNumber: Int) -> [String: String] {
        var parameters = [String: String]()
        parameters["method"] = "flickr.photos.search"
        parameters["api_key"] = "bd16f25ee095818ce86eebec9238f110"
        parameters["format"] = "json"
        parameters["nojsoncallback"] = "1"
        parameters["extras"] = "date_taken,tags,url_q,url_z"
        parameters["per_page"] = "16"
        parameters["tag_mode"] = "all"
        parameters["tags"] = searchTags
        parameters["page"] = "\(pageNumber)"
        parameters["sort"] = sortBy
        
        return parameters
    }
    
    private func url(params: [String : String]) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.flickr.com"
        components.path = "/services/rest/"
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1)}
        return components.url!
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
}
