//
//  TaskItem+CoreDataProperties.swift
//  Tasks Matrix
//
//  Created by Amante Castino on 7/11/23.
//
//

import Foundation
import CoreData


extension TaskItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskItem> {
        return NSFetchRequest<TaskItem>(entityName: "TaskItem")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var matrixRawEnumVal: String?
    @NSManaged public var notesRawStringValue: String?
    @NSManaged public var statusRawEnumVal: String?
    @NSManaged public var titleRawStringValue: String?

}

extension TaskItem : Identifiable {

}
