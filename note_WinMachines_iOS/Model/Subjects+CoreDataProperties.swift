//
//  Subjects+CoreDataProperties.swift
//  note_WinMachines_iOS
//
//  Created by Tej on 28/01/21.
//
//

import Foundation
import CoreData


extension Subjects {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Subjects> {
        return NSFetchRequest<Subjects>(entityName: "Subjects")
    }

    @NSManaged public var subject_id: Int32
    @NSManaged public var subject: String?

}

extension Subjects : Identifiable {

}
