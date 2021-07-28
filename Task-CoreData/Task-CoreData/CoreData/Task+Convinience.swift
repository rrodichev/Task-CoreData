//
//  Task+Convinience.swift
//  Task-CoreData
//
//  Created by Rozalia Rodichev on 7/27/21.
//

import CoreData

extension Task {
    @discardableResult
    convenience init(name: String, notes: String?, dueDate: Date?, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.name = name
        self.notes = notes
        self.dueDate = dueDate
    }
}
