//
//  HomeTests.swift
//  Fitsmind To-Do
//
//  Created by Atalyk Akash on 11/23/17.
//  Copyright © 2017 Atalyk Akash. All rights reserved.
//

import KIF
import RealmSwift
import Nimble
@testable import Fitsmind_To_Do

class HomeTests: KIFTestCase {
    
    override func beforeAll() {
        useTestDatabase()
    }
    
    func useTestDatabase() {
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "realm"
    }
    
    func tapButton(_ title: String) {
        tester().tapView(withAccessibilityLabel: title)
    }
    
    func testNotes() {
        haveNoNotes()
        expectNumberOfNotesInListToEqual(0)
        have3Notes()
        tapButton("add.button")
        tapButton("Back")
        expectNumberOfNotesInListToEqual(3)
    }
    
    func haveNoNotes() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func have3Notes() {
        for i in 0..<3 {
            let note = Note()
            note.title = "Note\(i)"
            note.content = "Content"
            note.priority = 1
            note.date = Date()
            note.save()
        }
    }

    
    func expectNumberOfNotesInListToEqual(_ count: Int) {
        let noteTableView = tester().waitForView(withAccessibilityLabel: "notes.tableview") as! UITableView
        expect(noteTableView.numberOfRows(inSection: 0)) == count
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
