//
//  NoteSpec.swift
//  Fitsmind To-Do
//
//  Created by Atalyk Akash on 11/22/17.
//  Copyright © 2017 Atalyk Akash. All rights reserved.
//

import Quick
import Nimble
import RealmSwift
@testable import Fitsmind_To_Do

class NoteSpec: QuickSpec {
        
    override func spec() {
        super.spec()
        
        Note().removeAll()
        let noteTitle = "Note"
        let noteContent = "Content"
        let notePriority = 1
        let noteDate = Date()
        let noteId = 0
        
        describe("CRUD operations") {
            describe("Create") {
                it("saves object to database correctly") {
                    let note = Note()
                    note.title = noteTitle
                    note.content = noteContent
                    note.priority = notePriority
                    note.date = noteDate
                    note.id = noteId
                    note.save()
                    let realm = try! Realm()
                    let noteFromDatabase = realm.objects(Note.self).last
                    expect(noteFromDatabase?.title) == note.title
                    expect(noteFromDatabase?.content) == note.content
                    expect(noteFromDatabase?.priority) == note.priority
                    expect(noteFromDatabase?.date) == note.date
                    expect(noteFromDatabase?.id) == note.id
                }
            }
            
            describe("Read") {
                beforeEach {
                    self.addNotes(count: 3)
                }
                
                describe("retrieving all objects") {
                    it("return all notes") {
                        let notes = Note().fetch()
                        expect(notes.count) == 3
                        expect(notes[0].title) == "Note0"
                        expect(notes[1].title) == "Note1"
                        expect(notes[2].title) == "Note2"
                    }
                }
                
                describe("search notes") {
                    it("return searched objects") {
                        self.addNotes(count: 3)
                        let notes = Note().search(title: "1")
                        expect(notes.count) == 1
                    }
                }
            }
            
            describe("Update") {
                let newTitle = "NewNote"
                let newContent = "NewContent"
                
                describe("update properties") {
                    it("updates notes to database") {
                        let note = Note()
                        note.title = noteTitle
                        note.content = noteContent
                        note.priority = notePriority
                        note.date = noteDate
                        note.id = noteId
                        note.save()
                        let realm = try! Realm()
                        try! realm.write {
                            note.title = newTitle
                            note.content = newContent
                        }
                        note.update()
                        let noteFromDatabase = realm.objects(Note.self).last
                        expect(noteFromDatabase?.title) == newTitle
                        expect(noteFromDatabase?.content) == newContent
                    }
                }
                
                describe("update with primary key") {
                    context("different id") {
                        it("updates nothing") {
                            Note().removeAll()
                            
                            let note = Note()
                            note.title = noteTitle
                            note.content = noteContent
                            note.priority = notePriority
                            note.date = noteDate
                            note.save()
                            
                            let newNote = Note()
                            newNote.title = newTitle
                            newNote.content = newContent
                            newNote.priority = notePriority
                            newNote.date = noteDate
                            newNote.id = note.id+1
                            newNote.update()
                            
                            let realm = try! Realm()
                            let notes = realm.objects(Note.self)
                            expect(notes.count) == 2
                            expect(notes.last?.title) == newTitle
                            expect(notes.last?.content) == newContent
                        }
                    }
                    
                    context("same id") {
                        it("update note to database") {
                            let note = Note()
                            note.removeAll()
                            note.title = noteTitle
                            note.content = noteContent
                            note.priority = notePriority
                            note.date = noteDate
                            note.id = 1
                            note.save()
                            
                            let newNote = Note()
                            newNote.title = newTitle
                            newNote.content = newContent
                            newNote.priority = notePriority
                            newNote.date = noteDate
                            newNote.id = 1
                            newNote.update()
                            let realm = try! Realm()
                            let noteFromDatabase = realm.objects(Note.self).last
                            expect(noteFromDatabase?.title) == newTitle
                            expect(noteFromDatabase?.content) == newContent
                        }
                    }
                }
            }
            describe("Delete") {
                context("delete single note") {
                    it("deletes record from database") {
                        let note = Note()
                        self.addNotes(count: 3)
                        let realm = try! Realm()
                        let deleteNote = realm.object(ofType: Note.self, forPrimaryKey: 1)
                        deleteNote?.remove()
                        let notes = note.fetch()
                        expect(notes.count) == 2
                        expect(notes[0].id) == 0
                        expect(notes[1].id) == 2
                    }
                }
                context("delete all notes") {
                    it("clear database") {
                        let note = Note()
                        self.addNotes(count: 3)
                        let realm = try! Realm()
                        let notes = realm.objects(Note.self)
                        expect(notes.count) == 3
                        note.removeAll()
                        let remainingNotes = realm.objects(Note.self)
                        expect(remainingNotes.count) == 0
                    }
                }
            }
        }
    }
    
}

extension NoteSpec {
    func addNotes(count: Int) {
        Note().removeAll()
        for i in 0..<count {
            let note = Note()
            note.title = "Note\(i)"
            note.content = "Content"
            note.priority = 1
            note.date = Date()
            note.save()
        }
    }
}

