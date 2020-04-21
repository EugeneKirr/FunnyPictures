//
//  NetworkError.swift
//  FunnyPictures
//
//  Created by Eugene Kireichev on 08/04/2020.
//  Copyright © 2020 Eugene Kireichev. All rights reserved.
//

import Foundation

struct NetworkError: NetworkErrorHandling {
    
    let errors: [String]
    
}

extension NetworkError {
    
    init(errorDescription: String) {
        self.errors = [errorDescription]
    }

}
