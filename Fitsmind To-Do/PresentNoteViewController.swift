//
//  PresentNoteViewController.swift
//  Fitsmind To-Do
//
//  Created by Atalyk Akash on 11/22/17.
//  Copyright © 2017 Atalyk Akash. All rights reserved.
//

import UIKit
import EasyPeasy

class PresentNoteViewController: UIViewController {

    var notesViewModel: NotesViewModel?
    var index: Int?
    
    private lazy var presentNoteView: PresentNoteView = {
        let presentNoteView = PresentNoteView()
        return presentNoteView
    }()
    
    private lazy var rightBarButtonItem: UIBarButtonItem = {
        let item = UIBarButtonItem(image: Constants.editImage, style: .plain, target: self, action: #selector(editNote))
        return item
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Note"
        
        navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        self.navigationController?.navigationBar.barTintColor = UIColor.mainColor
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    
    func editNote() {
        let newNoteViewController = NewNoteViewController()
        newNoteViewController.index = index
        newNoteViewController.notesViewModel = notesViewModel
        navigationController?.pushViewController(newNoteViewController, animated: true)
    }
    
    func updateUI() {
        if let i = index {
            presentNoteView.notesViewModel = notesViewModel
            presentNoteView.index = i
            presentNoteView.updateUI()
        }
    }
    
    private func setup() {
        navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationController?.navigationBar.isTranslucent = false
        view.addSubview(presentNoteView)
        updateViewConstraints()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        presentNoteView.easy.layout(Edges())
    }
}
