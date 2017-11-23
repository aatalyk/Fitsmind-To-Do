//
//  NotePresentViewModel.swift
//  Fitsmind To-Do
//
//  Created by Atalyk Akash on 11/21/17.
//  Copyright © 2017 Atalyk Akash. All rights reserved.
//

import Foundation

class NotesViewModel: NSObject {
    
    var note = Note()
    var notes: [Note]?
    
    func fetchNotes() {
        self.notes = note.fetch()
    }
    
    func removeNote(at index: Int) {
        self.notes?[index].remove()
    }
    
    func sortByDate() {
        self.notes?.sort(by: {
            $0.date.timeIntervalSince1970 > $1.date.timeIntervalSince1970
        })
    }
    
    func sortByPriority() {
        self.notes?.sort(by: {
            $0.priority > $1.priority
        })
    }
    
    func removeNotes() {
        note.removeAll()
        fetchNotes()
    }
    
    func searchNote(title: String) {
        self.notes = note.search(title: title)
    }
    
    func updateNote(id: Int, title: String, content: String, priority: Int, date: Date) {
        let note = Note()
        note.title = title
        note.content = content
        note.priority = priority
        note.date = date
        note.id = id
        note.update()
    }
    
    func numberOfItemsInSection() -> Int {
        return notes?.count ?? 0
    }
    
    func noteForItemAtIndexPath(indexPath: IndexPath) -> Note? {
        guard let notes = notes else {
            return nil
        }
        return notes[indexPath.row]
    }
}
