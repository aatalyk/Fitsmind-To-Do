//
//  NotesViewController.swift
//  Fitsmind To-Do
//
//  Created by Atalyk Akash on 11/21/17.
//  Copyright © 2017 Atalyk Akash. All rights reserved.
//

import UIKit
import EasyPeasy

class NotesViewController: UIViewController {
    
    var notesViewModel: NotesViewModel?
    var searchController: UISearchController!
    
    var menuHidden: Bool = true {
        didSet {
            menuView.isHidden = menuHidden
        }
    }
    
    fileprivate lazy var notesView: NotesView = {
        let notesView = NotesView()
        notesView.delegate = self
        notesView.accessibilityLabel = "notes"
        notesView.isAccessibilityElement = true
        return notesView
    }()
    
    fileprivate lazy var menuView: MenuView = {
        let menuView = MenuView(frame: .zero)
        menuView.layer.cornerRadius = 10
        menuView.delegate = self
        menuView.isHidden = true
        return menuView
    }()
    
    private lazy var leftBarButtonItem: UIBarButtonItem = {
        let item = UIBarButtonItem(image: Constants.moreImage, style: .plain, target: self, action: #selector(showMenu))
        return item
    }()
    
    private lazy var rightBarButtonItem: UIBarButtonItem = {
        let item = UIBarButtonItem(image: Constants.addImage, style: .plain, target: self, action: #selector(addNewNote))
        item.setValue("add.button", forKey: "accessibilityLabel")
        item.isAccessibilityElement = true
        return item
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        notesViewModel?.sortByPriority()
        notesView.notesViewModel = notesViewModel
    }
    
    @objc private func showMenu() {
        menuHidden = !menuHidden
    }
    
    @objc private func addNewNote() {
        let newNoteViewController = NewNoteViewController()
        newNoteViewController.newNoteViewModel = NewNoteViewModel()
        navigationController?.pushViewController(newNoteViewController, animated: true)
    }
    
    private func setup() {
        
        view.addSubview(notesView)
        view.addSubview(menuView)
        updateViewConstraints()
        notesView.notesViewModel = notesViewModel
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.searchBar.tintColor = .white
        
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        
        navigationItem.titleView = searchController.searchBar
        definesPresentationContext = true
        
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        navigationController?.navigationBar.barTintColor = UIColor.mainColor
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        menuView.easy.layout(
            Width(Constants.screenWidth*0.6),
            Height(Constants.screenWidth*0.6),
            CenterX(0).to(notesView, .centerX),
            CenterY(-20).to(notesView, .centerY)
        )
        
        notesView.easy.layout(Edges())
    }
}

extension NotesViewController: SelectMenuItemDelegate {
    func selectItem(at index: Int) {
        Constants.sorted = index
        menuHidden = !menuHidden
        notesView.updateUI()
    }
}

extension NotesViewController: SelecNoteDelegate {
    func selectNote(at index: Int) {
        let presentNoteViewController = PresentNoteViewController()
        presentNoteViewController.index = index
        presentNoteViewController.notesViewModel = notesViewModel
        navigationController?.pushViewController(presentNoteViewController, animated: true)
    }
}

extension NotesViewController: UISearchControllerDelegate, UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        notesView.searchNotes(title: searchText)
        if searchText.characters.count == 0 {
            notesView.updateUI()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        notesView.updateUI()
    }
}
