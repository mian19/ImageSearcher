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
    let farm: Int
    let title: String
    let ispublic, isfriend, isfamily: Int
    let datetaken: String
    let datetakengranularity: Int
    let datetakenunknown, tags: String
    let urlQ: String
    let heightQ, widthQ: Int
    let urlZ: String
    let heightZ, widthZ: Int

    enum CodingKeys: String, CodingKey {
        case id, owner, secret, server, farm, title, ispublic, isfriend, isfamily, datetaken, datetakengranularity, datetakenunknown, tags
        case urlQ = "url_q"
        case heightQ = "height_q"
        case widthQ = "width_q"
        case urlZ = "url_z"
        case heightZ = "height_z"
        case widthZ = "width_z"
    }
}

