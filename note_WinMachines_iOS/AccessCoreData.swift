//
//  AccessCoreData.swift
//  note_WinMachines_iOS
//
//  Created by Mac on 02/02/21.
//

import UIKit
import CoreData

class AccessCoreData: NSObject {
    static let context =
        (UIApplication.shared.delegate as! AppDelegate)
        .persistentContainer.viewContext
    
   static func fetchNotes() -> [Notes]?{
        var notes : [Notes]?
        do {
         notes = try AccessCoreData.context.fetch(Notes.fetchRequest())
        } catch  {
            
        }
        return notes
    }
    static func fetchNotesWithSubject(subject: Subjects) -> [Notes]?{
        let predicate =  NSPredicate(format: "subject.subjectName = %@", subject.subjectName!)
         var notes : [Notes]?
        let fetch : NSFetchRequest<Notes> = Notes.fetchRequest()
        fetch.predicate = predicate
         do {
          notes = try AccessCoreData.context.fetch(fetch)
         } catch  {
             
         }
         return notes
     }
    static func fetchSubjects() -> [Subjects]?{
        var subjects : [Subjects]?
        do {
            subjects = try AccessCoreData.context.fetch(Subjects.fetchRequest())
        } catch  {
            
        }
        return subjects
    }
    static func deleteNote(note : Notes){
        AccessCoreData.context.delete(note)
        saveCoreData()
        
    }
    static func saveCoreData(){
        do {
            try AccessCoreData.context.save()
        } catch  {
            
        }
    }
    static func addSubject(subjectName: String){
        let subject = Subjects(context: AccessCoreData.context)
        subject.subjectName = subjectName
        AccessCoreData.saveCoreData()
    }
    static func deleteSubject(subjectSubject : Subjects){
        let arrNote = AccessCoreData.fetchNotesWithSubject(subject: subjectSubject)!
        for note in arrNote{
            AccessCoreData.deleteNote(note: note)
        }
        AccessCoreData.context.delete(subjectSubject)
        saveCoreData()
        
    }

}
