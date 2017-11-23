//
//  Helpers.swift
//  To-Do
//
//  Created by Atalyk Akash on 11/21/17.
//  Copyright © 2017 Atalyk Akash. All rights reserved.
//

import UIKit
import Foundation

struct Constants {
    static let addTitle = "Please, add a title for the note"
    static let noteCell = "NoteCell"
    static let taskTitle = "Task"
    static let taskContent = "Description"
    static let upPriority = "👍🏽"
    static let downPriority = "👎🏽"
    static let clock = "🕓"
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    static let sortByDate = "Sort by date"
    static let sortByPriority = "Sort by priority"
    static let removeAll = "Remove notes"
    static let menuCell = "MenuCell"
    static var sorted = -1
    static let moreImage = UIImage(named: "more")?.withRenderingMode(.alwaysOriginal)
    static let addImage = UIImage(named: "add")?.withRenderingMode(.alwaysOriginal)
    static let editImage = UIImage(named: "edit")?.withRenderingMode(.alwaysOriginal)
}

protocol SelectMenuItemDelegate: class {
    func selectItem(at index: Int)
}

protocol SelecNoteDelegate: class {
    func selectNote(at index: Int)
}

protocol NewNoteViewDelegate: class {
    func callAlertAction()
}
