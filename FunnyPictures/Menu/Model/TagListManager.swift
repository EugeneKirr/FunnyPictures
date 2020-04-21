//
//  TagListManager.swift
//  FunnyPictures
//
//  Created by Eugene Kireichev on 07/04/2020.
//  Copyright © 2020 Eugene Kireichev. All rights reserved.
//

import Foundation

class TagListManager {
    
    private let initialTagsList = TagList(tags: ["Animals", "Sportcars", "Mountains", "Video games"])
        
    func fetchTagList() -> TagList {
        let defaults = UserDefaults.standard
        guard let savedTagList = defaults.object(forKey: UDKeys.tagList.rawValue) as? Data else { return initialTagsList }
        let decoder = JSONDecoder()
        guard let fetchedTagList = try? decoder.decode(TagList.self, from: savedTagList) else { return initialTagsList }
        return fetchedTagList
    }
    
    func addToTagList(_ newTag: String?) {
        guard let tag = newTag, tag != "" else { return }
        var newTags = self.fetchTagList().tags
        guard !newTags.contains(tag) else { return }
        newTags.append(tag)
        self.putToUserDefaults(tagList: TagList(tags: newTags) )
    }
    
    private func putToUserDefaults(tagList: TagList) {
        let encoder = JSONEncoder()
        guard let encodedTagList = try? encoder.encode(tagList) else { return }
        let defaults = UserDefaults.standard
        defaults.set(encodedTagList, forKey: UDKeys.tagList.rawValue)
    }
    
    func removeFromTagList(tagIndex: Int) {
        var newTags = self.fetchTagList().tags
        newTags.remove(at: tagIndex)
        self.putToUserDefaults(tagList: TagList(tags: newTags) )
    }
    
}
