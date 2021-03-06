//
//  Entry+Convenience.swift
//  Core-Data-Journal
//
//  Created by Madison Waters on 11/5/18.
//  Copyright © 2018 Jonah Bergevin. All rights reserved.
//

import Foundation
import CoreData

extension Entry {
    
    convenience init(title: String,
                     bodyText: String,
                     identifier: String = "",
                     timestamp: Date = Date(),
                     context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.title = title
        self.bodyText = bodyText
        self.identifier = identifier
        self.timestamp = timestamp
    }
    
}
