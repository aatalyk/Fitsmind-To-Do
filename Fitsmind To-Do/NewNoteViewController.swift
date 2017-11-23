//
//  NewNoteViewController.swift
//  Fitsmind To-Do
//
//  Created by Atalyk Akash on 11/21/17.
//  Copyright © 2017 Atalyk Akash. All rights reserved.
//

import UIKit
import EasyPeasy

class NewNoteViewController: UIViewController {
    
    var newNoteViewModel: NewNoteViewModel?
    var notesViewModel: NotesViewModel?
    var index: Int?
    
    private lazy var newNoteView: NewNoteView = {
        let newNoteView = NewNoteView()
        newNoteView.delegate = self
        return newNoteView
    }()
    
    let alertController = UIAlertController()
    fileprivate var alertAction: UIAlertAction = {
        let alert = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.accessibilityLabel = "OK"
        alert.isAccessibilityElement = true
        return alert
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        newNoteView.resetButton(title: "Save", color: UIColor.mainColor, toggle: true)
    }
    
    private func setup() {
        navigationController?.navigationBar.isTranslucent = false
        view.addSubview(newNoteView)
        updateViewConstraints()
        
        newNoteView.newNoteViewModel = newNoteViewModel
        newNoteView.notesViewModel = notesViewModel
        newNoteView.index = index
        newNoteView.updateEditUI()
        
        title = "Note"
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        navigationController?.navigationBar.barTintColor = UIColor.mainColor
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        alertController.message = Constants.addTitle
        alertController.view.subviews[0].subviews[0].subviews[0].subviews[0].subviews[0].subviews[1].accessibilityLabel = "alert"
        alertController.isAccessibilityElement = true
        alertController.addAction(alertAction)
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        newNoteView.easy.layout(Edges())
    }

}

extension NewNoteViewController: NewNoteViewDelegate {
    func callAlertAction() {
        present(alertController, animated: true, completion: nil)
    }
}
