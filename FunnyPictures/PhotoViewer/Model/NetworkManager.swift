//
//  NetworkManager.swift
//  FunnyPictures
//
//  Created by Eugene Kireichev on 02/04/2020.
//  Copyright © 2020 Eugene Kireichev. All rights reserved.
//

import Foundation

class NetworkManager {
    
    private let accessKey = "3J5ZcTEF-gHZ3hzOZUQY-WhvvdWTIYCPcCnCRhbHD-A"
    
    enum NetworkRequest {
        case randomPhoto(_ query: String)
        case byID(_ identifier: String)
    }
    
    func fetchRawPhotoData<M: Decodable, E: NetworkErrorHandling>(request: NetworkRequest, completionHandler: @escaping (Result<M, E>) -> Void) {
        var urlString = "https://api.unsplash.com/photos/"
        switch request {
        case .randomPhoto(let query):
            let queryRejoined = query.split(separator: " ").joined(separator: "%20")
            urlString += "random?query=\(queryRejoined)&client_id=\(accessKey)"
        case .byID(let identifier):
            urlString += "\(identifier)/?client_id=\(accessKey)"
        }
        guard let url = URL(string: urlString) else { print("can't create url"); return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, _, _) in
            guard let data = data else { print("no JSON data received"); return }
            let result: Result<M, E> = self.parseJSONtoRawModel(data: data)
            DispatchQueue.main.async {
                completionHandler(result)
            }
        }
        task.resume()
    }
    
    func parseJSONtoRawModel<M: Decodable, E: NetworkErrorHandling>(data: Data) -> Result<M, E> {
        let decoder = JSONDecoder()
        guard let rawPhotoData = try? decoder.decode(M.self, from: data) else {
            guard let errorFromJSON = try? decoder.decode(E.self, from: data) else {
                let errorFromString = E(errorDescription: String(data: data, encoding: .utf8) ?? "Unknown error")
                return .failure(errorFromString)
            }
            return .failure(errorFromJSON)
        }
        return .success(rawPhotoData)
    }

}
