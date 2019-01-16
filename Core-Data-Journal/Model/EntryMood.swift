//
//  EntryMood.swift
//  Core-Data-Journal
//
//  Created by Madison Waters on 1/15/19.
//  Copyright © 2019 Jonah Bergevin. All rights reserved.
//

import Foundation

enum EntryMood: String, CaseIterable {
    
    case 🙁
    case 😐
    case 🙂
    
}

extension Entry {
    
    var entryMood: EntryMood {
        get {
            return EntryMood(rawValue: mood!) ?? .😐
        }
        set {
            mood = newValue.rawValue
        }
    }
}
