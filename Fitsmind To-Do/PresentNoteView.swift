
//
//  PresentNoteView.swift
//  Fitsmind To-Do
//
//  Created by Atalyk Akash on 11/22/17.
//  Copyright © 2017 Atalyk Akash. All rights reserved.
//

import UIKit
import KMPlaceholderTextView
import EasyPeasy

class PresentNoteView: BaseView {
    
    var notesViewModel: NotesViewModel?
    var index: Int?

    private lazy var titleTextfield: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = Constants.taskTitle
        textfield.font = UIFont.customBold
        return textfield
    }()
    
    private lazy var contentTextView: KMPlaceholderTextView = {
        let textView = KMPlaceholderTextView()
        textView.placeholder = Constants.taskContent
        textView.font = UIFont.customRegular
        textView.contentInset = UIEdgeInsetsMake(0, -5, 0, 0)
        return textView
    }()
    
    private lazy var priorityLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.textAlignment = .left
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        return label
    }()
    
    override func setup() {
        self.backgroundColor = UIColor.white
        self.addSubview(titleTextfield)
        self.addSubview(contentTextView)
        self.addSubview(priorityLabel)
        self.addSubview(dateLabel)
        updateConstraints()
    }
    
    func updateUI() {
        guard let i = index else {
            return
        }
        
        notesViewModel?.fetchNotes()
        
        if Constants.sorted == 0 {
            notesViewModel?.sortByDate()
        } else if Constants.sorted == 1 {
            notesViewModel?.sortByPriority()
        } else if Constants.sorted == 2 {
            notesViewModel?.removeNotes()
            Constants.sorted = -1
        }
        
        guard let note = notesViewModel?.notes?[i] else {
            return
        }
        
        titleTextfield.text = note.title
        contentTextView.text = note.content
        priorityLabel.text = "👍🏽\(note.priority)"
        dateLabel.text = Date.getDate(date: note.date)
    }

    override func updateConstraints() {
        super.updateConstraints()
        
        titleTextfield.easy.layout(
            Top(10),
            Width(Constants.screenWidth*0.8),
            Height(50),
            CenterX(0).to(self)
        )
        
        contentTextView.easy.layout(
            Top(10).to(titleTextfield, .bottom),
            Width(Constants.screenWidth*0.8),
            Height(Constants.screenHeight*0.25),
            CenterX(0).to(self)
        )
        
        priorityLabel.easy.layout(
            Top(10).to(contentTextView, .bottom),
            Width(Constants.screenWidth*0.2),
            Height(40),
            Left(0).to(contentTextView, .left)
        )
        
        dateLabel.easy.layout(
            Top(10).to(contentTextView, .bottom),
            Height(40),
            Left(10).to(priorityLabel, .right),
            Right(0).to(contentTextView, .right)
        )
    }
}
