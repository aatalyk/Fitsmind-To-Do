//
//  MenuView.swift
//  Fitsmind To-Do
//
//  Created by Atalyk Akash on 11/22/17.
//  Copyright © 2017 Atalyk Akash. All rights reserved.
//

import UIKit
import EasyPeasy

class MenuView: BaseView {
    
    let items = [Constants.sortByDate, Constants.sortByPriority, Constants.removeAll]
    
    weak var delegate: SelectMenuItemDelegate?
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = Constants.screenWidth*0.2
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.menuCell)
        return tableView
    }()

    override func setup() {
        self.addSubview(tableView)
        updateConstraints()
    }
    
    override func updateConstraints() {
        self.layer.masksToBounds = true
        super.updateConstraints()
        tableView.easy.layout(Edges())
    }
}

extension MenuView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.selectItem(at: indexPath.row)
    }
}

extension MenuView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.menuCell, for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        cell.backgroundColor = UIColor.mainColor
        cell.textLabel?.textColor = .white
        cell.textLabel?.textAlignment = .center
        return cell
    }
}
