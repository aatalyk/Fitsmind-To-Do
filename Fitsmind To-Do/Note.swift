//
//  Note.swift
//  To-Do
//
//  Created by Atalyk Akash on 11/21/17.
//  Copyright © 2017 Atalyk Akash. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class Note: Object {
    dynamic var title = ""
    dynamic var content = ""
    dynamic var priority = 1
    dynamic var date = Date()
    dynamic var id = 0
    
    override class func primaryKey() -> String? {
        return "id"
    }

    func save() {
        do {
            let realm = try Realm()
            let nodes = realm.objects(Note.self)
            try realm.write {
                self.id = nodes.count
                realm.add(self)
            }
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }
    
    func update() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(self, update: true)
            }
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }
    
    func remove() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(self)
            }
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }
    
    func removeAll() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.deleteAll()
            }
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }
    
    func search(title: String) -> [Note] {
        var notes: [Note] = []
        let predicate = NSPredicate(format: "title contains[c] %@", title)
        do {
            let realm = try Realm()
            notes = realm.objects(Note.self).filter(predicate).toArray(ofType: Note.self) as [Note]
        } catch let error {
            fatalError(error.localizedDescription)
        }
        return notes
    }
    
    func fetch() -> [Note] {
        var notes: [Note] = []
        do {
            let realm = try Realm()
            notes = realm.objects(Note.self).toArray(ofType: Note.self) as [Note]
        } catch let error {
            fatalError(error.localizedDescription)
        }
        return notes
    }
}
