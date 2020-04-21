//
//  Hints.swift
//  FunnyPictures
//
//  Created by Eugene Kireichev on 10/04/2020.
//  Copyright © 2020 Eugene Kireichev. All rights reserved.
//

import Foundation

enum Hints {
    
    case menu
    case photoViewer
    case myCollection
    case customizer
    
}

extension Hints {
    
    var udKey: String {
        switch self {
        case .menu: return "MenuHint"
        case .photoViewer: return "PhotoViewerHint"
        case .myCollection: return "MyCollectionHint"
        case .customizer: return "CustomizerHint"
        }
    }
    
    var hintText: String {
        switch self {
        case .menu: return "Tap Add button to enter new tag.\nIf left blank or already exist\nnothing will be added"
        case .photoViewer: return "Double tap on photo\nto add in My Collection"
        case .myCollection: return "Tap Trash button and after on Cells to remove.\nWhen finish tap Trash button again"
        case .customizer: return "Here you can customize app background color"
        }
    }
    
}



