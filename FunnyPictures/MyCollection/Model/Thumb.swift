//
//  Thumb.swift
//  FunnyPictures
//
//  Created by Eugene Kireichev on 10/04/2020.
//  Copyright © 2020 Eugene Kireichev. All rights reserved.
//

import UIKit

struct Thumb {

    let thumbnail: UIImage?

}

extension Thumb {
    
    init(_ rawPhotoData: RawPhotoData) {
        self.thumbnail = {
            let thumbURLString = rawPhotoData.urls.thumb
            guard let thumbURL = URL(string: thumbURLString),
                  let thumbData = try? Data(contentsOf: thumbURL) else { return nil }
            return UIImage(data: thumbData)
        }()
    }
}

extension Thumb {
    
    static func createInstanceAsync(from rawPhotoData: RawPhotoData, completion: @escaping (Thumb) -> Void) {
        DispatchQueue.global(qos: .background).async {
            guard let thumbURL = URL(string: rawPhotoData.urls.thumb),
                  let thumbData = try? Data(contentsOf: thumbURL),
                  let thumbnail = UIImage(data: thumbData) else { return }
            let thumb = Thumb(thumbnail: thumbnail)
            DispatchQueue.main.async {
                completion(thumb)
            }
        }
    }
    
}
