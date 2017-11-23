//
//  NoteViewModel.swift
//  To-Do
//
//  Created by Atalyk Akash on 11/21/17.
//  Copyright © 2017 Atalyk Akash. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class NewNoteViewModel: NSObject {
    
    func saveNote(title: String, content: String, priority: Int, date: Date) {
        let note = Note()
        note.title = title
        note.content = content
        note.priority = priority
        note.date = date
        note.save()
    }
}
