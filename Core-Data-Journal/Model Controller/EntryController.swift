//
//  EntryController.swift
//  Core-Data-Journal
//
//  Created by Madison Waters on 11/5/18.
//  Copyright © 2018 Jonah Bergevin. All rights reserved.
//

import Foundation
import CoreData

class EntryController {
    
    // MARK: - Properties
    
    var entries: [Entry] {
        let fetchRequest: NSFetchRequest<Entry> = Entry.fetchRequest()
        let results = (try? CoreDataStack.shared.mainContext.fetch(fetchRequest)) ?? []
        return results
    }
    
    // MARK: - CRUD Methods
    
    func createEntry(title: String, bodyText: String, mood: String) {
        
        let _ = Entry(title: title, bodyText: bodyText, mood: mood)
        saveToPersistentStore()
    }
    
    func updateEntry(entry: Entry, title: String, bodyText: String, mood: String) {
        
        entry.title = title
        entry.bodyText = bodyText
        entry.mood = mood
        saveToPersistentStore()
    }
    
    func deleteEntry(entry: Entry) {
        
        let moc = CoreDataStack.shared.mainContext
        moc.delete(entry)
        saveToPersistentStore()
    }
    
    // MARK: - Persistent Store Methods
    
    func saveToPersistentStore() {
        let moc = CoreDataStack.shared.mainContext
        do {
            try moc.save()
        } catch {
            NSLog("Error saving to managed object context")
        }
    }
    
    func loadFromPersistentStore() -> [Entry]{
        let fetchRequest: NSFetchRequest<Entry> = Entry.fetchRequest()
        let moc = CoreDataStack.shared.mainContext
        
        do {
            return try moc.fetch(fetchRequest)
        } catch {
            NSLog("Error fetching entries: \(error)")
            return []
        }
    }
    
}


