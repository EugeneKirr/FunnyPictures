//
//  NetworkErrorHandling.swift
//  FunnyPictures
//
//  Created by Eugene Kireichev on 14/04/2020.
//  Copyright © 2020 Eugene Kireichev. All rights reserved.
//

import Foundation

protocol NetworkErrorHandling: Error, Codable {
    
    init(errorDescription: String)
    
}
