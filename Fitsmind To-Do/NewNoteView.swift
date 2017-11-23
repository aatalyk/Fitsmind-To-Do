//
//  NewNoteView.swift
//  Fitsmind To-Do
//
//  Created by Atalyk Akash on 11/21/17.
//  Copyright © 2017 Atalyk Akash. All rights reserved.
//

import UIKit
import EasyPeasy
import KMPlaceholderTextView

class NewNoteView: BaseView {
    
    weak var delegate: NewNoteViewDelegate?
    var newNoteViewModel: NewNoteViewModel?
    var notesViewModel: NotesViewModel?
    var index: Int?
    private var priority = 1
    private var datePickerHidden = true

    private lazy var titleTextfield: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = Constants.taskTitle
        textfield.font = UIFont.customBold
        textfield.accessibilityLabel = "note.title"
        textfield.isAccessibilityElement = true
        return textfield
    }()
    
    private lazy var contentTextView: KMPlaceholderTextView = {
        let textView = KMPlaceholderTextView()
        textView.placeholder = Constants.taskContent
        textView.font = UIFont.customRegular
        textView.contentInset = UIEdgeInsetsMake(0, -5, 0, 0)
        return textView
    }()
    
    private lazy var datePickerView: DatePickerView = {
        let pickerView = DatePickerView()
        return pickerView
    }()
    
    private lazy var priorityLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var upButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.upPriority, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(setNotePriority(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var downButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.downPriority, for: .normal)
        button.addTarget(self, action: #selector(setNotePriority(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var clockButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.clock, for: .normal)
        button.addTarget(self, action: #selector(showDatePicker), for: .touchUpInside)
        return button
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.backgroundColor = UIColor.mainColor
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(saveNote), for: .touchUpInside)
        button.accessibilityLabel = "save.button"
        button.isAccessibilityElement = true
        return button
    }()
    
    override func setup() {
        self.backgroundColor = .white
        
        self.addSubview(titleTextfield)
        self.addSubview(contentTextView)
        self.addSubview(datePickerView)
        self.addSubview(upButton)
        self.addSubview(priorityLabel)
        self.addSubview(downButton)
        self.addSubview(clockButton)
        self.addSubview(saveButton)
        
        updateConstraints()
    }
    
    func updateEditUI() {
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
        priorityLabel.text = "\(note.priority)"
        priority = note.priority
        datePickerView.datePicker.date = note.date
    }
    
    func resetButton(title: String, color: UIColor, toggle: Bool) {
        saveButton.setTitle(title, for: .normal)
        saveButton.backgroundColor = color
        saveButton.isUserInteractionEnabled = toggle
    }
    
    @objc private func saveNote() {
        
        let id = notesViewModel?.notes?.count ?? 0
        
        guard let title = titleTextfield.text else {
            return
        }
        
        if title.characters.count == 0 {
            delegate?.callAlertAction()
            return
        }
        
        guard let content = contentTextView.text else {
            return
        }
        
        let date = datePickerView.datePicker.date
        
        if notesViewModel == nil {
            newNoteViewModel?.saveNote(title: title, content: content, priority: priority, date: date)
        } else {
            notesViewModel?.updateNote(id: id, title: title, content: content, priority: priority, date: date)
        }
        resetButton(title: "Saved", color: .lightGray, toggle: false)
    }
    
    @objc private func setNotePriority(_ sender: UIButton) {
        guard let title = sender.currentTitle else {
            return
        }
        if title == Constants.upPriority {
            if priority < 4 {
                priority += 1
            }
        } else {
            if priority > 1 {
                priority -= 1
            }
        }
        priorityLabel.text = "\(priority)"
    }
    
    @objc private func showDatePicker() {
        if datePickerHidden {
            datePickerView.easy.layout(Top(0).to(self.saveButton, .bottom))
        } else {
            datePickerView.easy.layout(Top(0).to(self, .bottom))
        }
        datePickerHidden = !datePickerHidden
        datePickerView.layoutIfNeeded()
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
        
        upButton.easy.layout(
            Top(10).to(contentTextView, .bottom),
            Width(Constants.screenWidth*0.125),
            Height(40),
            Left(-Constants.screenWidth*0.05).to(contentTextView, .left)
        )
        
        priorityLabel.easy.layout(
            Top(10).to(contentTextView, .bottom),
            Width(Constants.screenWidth*0.125),
            Height(40),
            Left(0).to(upButton, .right)
        )
        
        downButton.easy.layout(
            Top(10).to(contentTextView, .bottom),
            Width(Constants.screenWidth*0.125),
            Height(40),
            Left(0).to(priorityLabel, .right)
        )
        
        clockButton.easy.layout(
            Top(10).to(contentTextView, .bottom),
            Width(Constants.screenWidth*0.125),
            Height(40),
            Left(0).to(downButton, .right)
        )
        
        saveButton.easy.layout(
            Top(10).to(contentTextView, .bottom),
            Width(Constants.screenWidth*0.4),
            Height(40),
            Right(-Constants.screenWidth*0.05).to(contentTextView, .right)
        )
        
        datePickerView.easy.layout(
            Top(0).to(self, .bottom),
            Height(Constants.screenHeight*0.4),
            Width(Constants.screenWidth*0.8),
            CenterX(0).to(self)
        )
    }
}
