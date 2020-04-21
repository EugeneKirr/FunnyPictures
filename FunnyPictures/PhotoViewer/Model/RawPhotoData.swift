//
//  RawPhotoData.swift
//  FunnyPictures
//
//  Created by Eugene Kireichev on 02/04/2020.
//  Copyright © 2020 Eugene Kireichev. All rights reserved.
//

import Foundation

struct RawPhotoData: Codable {
    
    let id: String
    let altDescription: String?
    let urls: Urls
    let likes: Int
    let user: User
    let views: Int
    let downloads: Int
}

extension RawPhotoData {
    enum CodingKeys: String, CodingKey {
        case id
        case altDescription = "alt_description"
        case urls, likes, user, views, downloads
    }
}

struct Urls: Codable {
    let regular: String
    let thumb: String
}

struct User: Codable {
    let name: String
    let location: String?
}
