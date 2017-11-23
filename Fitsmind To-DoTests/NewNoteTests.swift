//
//  NewNoteTests.swift
//  Fitsmind To-Do
//
//  Created by Atalyk Akash on 11/23/17.
//  Copyright © 2017 Atalyk Akash. All rights reserved.
//

import KIF
import Nimble

class NewNoteTests: KIFTestCase {
    
    override func beforeAll() {
        tapButton("add.button")
    }
    
    func testCreateNewNote() {
        clearOutNoteTitleField()
        tapButton("save.button")
        expectToSeeAlert(text: "alert")
        tapButton("OK")
        fillNoteTitle()
        tapButton("save.button")
        tapButton("Back")
        expectToSeeNoteWithTitle(title: "New note", atRow: 0)
    }
    
    func tapButton(_ title: String) {
        tester().tapView(withAccessibilityLabel: title)
    }
    
    func clearOutNoteTitleField() {
        tester().clearTextFromView(withAccessibilityLabel: "note.title")
    }
    
    func expectToSeeAlert(text: String) {
        tester().waitForView(withAccessibilityLabel: text)
    }
    
    func fillNoteTitle() {
        tester().enterText("New note", intoViewWithAccessibilityLabel: "note.title")
    }

    func expectToSeeNoteWithTitle(title: String, atRow row: NSInteger) {
        let indexPath = IndexPath(row: 1, section: 0)
        let noteCell = tester().waitForCell(at: indexPath, inTableViewWithAccessibilityIdentifier: "notes.tableview.id")
        expect(noteCell?.textLabel?.text) == title
    }
}
