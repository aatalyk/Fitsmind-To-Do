//
//  NotesView.swift
//  To-Do
//
//  Created by Atalyk Akash on 11/21/17.
//  Copyright © 2017 Atalyk Akash. All rights reserved.
//

import UIKit
import EasyPeasy

class NotesView: BaseView {
    
    var notesViewModel: NotesViewModel? {
        didSet {
            updateUI()
        }
    }
    
    weak var delegate: SelecNoteDelegate?
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.accessibilityLabel = "notes.tableview"
        tableView.accessibilityIdentifier = "notes.tableview.id"
        tableView.isAccessibilityElement = true
        tableView.register(NoteTableViewCell.self, forCellReuseIdentifier: Constants.noteCell)
        return tableView
    }()

    override func setup() {
        self.addSubview(tableView)
        updateConstraints()
        updateUI()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        tableView.easy.layout(Edges())
    }
    
    func updateNotes() {
        tableView.reloadData()
    }
    
    func searchNotes(title: String) {
        notesViewModel?.searchNote(title: title)
        
        if Constants.sorted == 0 {
            notesViewModel?.sortByDate()
        } else if Constants.sorted == 1 {
            notesViewModel?.sortByPriority()
        } else if Constants.sorted == 2 {
            notesViewModel?.removeNotes()
            Constants.sorted = -1
        }
        
        tableView.reloadData()
    }

    func updateUI() {
        notesViewModel?.fetchNotes()
        
        if Constants.sorted == 0 {
            notesViewModel?.sortByDate()
        } else if Constants.sorted == 1 {
            notesViewModel?.sortByPriority()
        } else if Constants.sorted == 2 {
            notesViewModel?.removeNotes()
            Constants.sorted = -1
        }
        
        tableView.reloadData()
    }
}

extension NotesView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.selectNote(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        notesViewModel?.removeNote(at: indexPath.row)
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        delete.backgroundColor = .red
        notesViewModel?.fetchNotes()
        return [delete]
    }
}

extension NotesView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesViewModel?.numberOfItemsInSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.noteCell, for: indexPath) as! NoteTableViewCell
        if let note = notesViewModel?.noteForItemAtIndexPath(indexPath: indexPath) {
            cell.textLabel?.text = note.title
        }
        return cell
    }
}

