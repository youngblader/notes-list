//
//  Note+CoreDataProperties.swift
//  NoteX
//
//  Created by Евгений Зорич on 22.02.24.
//
//

import Foundation
import CoreData

extension Note {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var name: String?
    @NSManaged public var createdAt: Date?

}

extension Note: Identifiable {

}
