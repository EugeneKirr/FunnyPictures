//
//  Photo.swift
//  FunnyPictures
//
//  Created by Eugene Kireichev on 02/04/2020.
//  Copyright © 2020 Eugene Kireichev. All rights reserved.
//

import UIKit

struct Photo {
    
    let id: String
    let image: UIImage?
    let description: String?
    let authorName: String
    let authorLocation: String?
    let viewsCount: String
    let likesCount: String
    let downloadsCount: String

}
    
extension Photo {
    
    init(_ rawPhotoData: RawPhotoData) {
        
        self.id = rawPhotoData.id
        self.description = rawPhotoData.altDescription
        self.authorName = rawPhotoData.user.name
        self.authorLocation = rawPhotoData.user.location
        self.viewsCount = "\(rawPhotoData.views)"
        self.likesCount = "\(rawPhotoData.likes)"
        self.downloadsCount = "\(rawPhotoData.downloads)"
        self.image = {
            let imageURLString = rawPhotoData.urls.regular
            guard let imageURL = URL(string: imageURLString) else { return nil }
            guard let imageData = try? Data(contentsOf: imageURL) else { print("can't create image"); return nil }
            return UIImage(data: imageData)
        }()
    }
    
}
