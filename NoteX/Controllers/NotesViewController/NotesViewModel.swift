//
//  NotesViewModel.swift
//  NoteX
//
//  Created by Евгений Зорич on 22.02.24.
//

import Foundation
import UIKit

protocol NotesViewModelProtocol {
    var onNoteItemsSaved: (([Note])->())? { get set }
    func addNoteItem(_ name: String) -> Void
    func retrieveNoteItems() -> Void
    func editNoteItem(_ note: Note, _ updateName: String) -> Void
    func removeNoteItem(_ note: Note) -> Void
    func saveNoteItems() -> Void
}

final class NotesViewModel: NotesViewModelProtocol {
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var onNoteItemsSaved: (([Note]) ->())?
    
    private var notes: [Note] = [] {
        didSet {
            onNoteItemsSaved?(notes)
        }
    }
    
    func addNoteItem(_ name: String) {
        let newItem = Note(context: context)
        
        newItem.name = name
        newItem.createdAt = Date()
        
        saveNoteItems()
    }
    
    func retrieveNoteItems() {
        do {
            let notes = try context.fetch(Note.fetchRequest())
            
            self.notes = notes
        } catch {
            print("!!!ERROR", error.localizedDescription)
        }
    }
    
    func editNoteItem(_ note: Note, _ updateName: String) {
        note.name = updateName
        saveNoteItems()
    }
    
    func removeNoteItem(_ note: Note) {
        context.delete(note)
        saveNoteItems()
    }
    
    func saveNoteItems() {
        if context.hasChanges {
            do {
                try context.save()
                retrieveNoteItems()
            } catch {
                context.rollback()
                print("!!!ERROR", error.localizedDescription)
            }
        }
    }
}
