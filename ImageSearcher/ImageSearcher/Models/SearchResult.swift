//
//  Photo.swift
//  testFlickr
//
//  Created by Kyzu on 29.11.22.
//

import Foundation

// MARK: - SearchResults
struct SearchResults: Codable {
    let photos: Photos
    let stat: String
}

// MARK: - Photos
struct Photos: Codable {
    let page, pages, perpage, total: Int
    let photo: [Photo]
}

// MARK: - Photo
struct Photo: Codable {
    let id, owner, secret, server: String
    let title: String
    let datetaken: String
    let tags: String
    let urlQ: String?
    let urlZ: String?

    enum CodingKeys: String, CodingKey {
        case id, owner, secret, server, title, datetaken, tags
        case urlQ = "url_q"
        case urlZ = "url_z"
    }
}

