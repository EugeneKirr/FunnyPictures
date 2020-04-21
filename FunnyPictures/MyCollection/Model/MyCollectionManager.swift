//
//  MyCollectionManager.swift
//  FunnyPictures
//
//  Created by Eugene Kireichev on 09/04/2020.
//  Copyright © 2020 Eugene Kireichev. All rights reserved.
//

import Foundation

class MyCollectionManager {
    
    private let emptyCollection = MyCollection(identifiers: [])
    
    func fetchCollection() -> MyCollection {
        let defaults = UserDefaults.standard
        guard let savedCollection = defaults.object(forKey: UDKeys.myCollection.rawValue) as? Data else { return emptyCollection }
        let decoder = JSONDecoder()
        guard let fetchedCollection = try? decoder.decode(MyCollection.self, from: savedCollection) else { return emptyCollection }
        return fetchedCollection
    }
    
    func addToCollection(_ id: String) {
        var newIDs = self.fetchCollection().identifiers
        guard !newIDs.contains(id) else { return }
        newIDs.append(id)
        self.putToUserDefaults(collection: MyCollection(identifiers: newIDs) )
    }

    private func putToUserDefaults(collection: MyCollection) {
        let encoder = JSONEncoder()
        guard let encodedCollection = try? encoder.encode(collection) else { return }
        let defaults = UserDefaults.standard
        defaults.set(encodedCollection, forKey: UDKeys.myCollection.rawValue)
    }
    
    func removeFromCollection(cellIndex: Int) {
        var newIDs = self.fetchCollection().identifiers
        newIDs.remove(at: cellIndex)
        self.putToUserDefaults(collection: MyCollection(identifiers: newIDs) )
    }
    
}
