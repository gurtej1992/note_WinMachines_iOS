//
//  Notes+CoreDataProperties.swift
//  note_WinMachines_iOS
//
//  Created by Tej on 28/01/21.
//
//

import Foundation
import CoreData


extension Notes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Notes> {
        return NSFetchRequest<Notes>(entityName: "Notes")
    }

    @NSManaged public var note_id: Int32
    @NSManaged public var subject_id: Int32
    @NSManaged public var lat: Double
    @NSManaged public var long: Double
    @NSManaged public var note_content: String?
    @NSManaged public var note_title: String?
    @NSManaged public var date_created: Date?
    @NSManaged public var date_modified: Date?
    @NSManaged public var note_image: String?
    @NSManaged public var note_audio: String?

}

extension Notes : Identifiable {

}
