//
//  NoteTableViewCell.swift
//  Fitsmind To-Do
//
//  Created by Atalyk Akash on 11/21/17.
//  Copyright © 2017 Atalyk Akash. All rights reserved.
//

import UIKit
import EasyPeasy

class NoteTableViewCell: UITableViewCell {

    let itemLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    private func setup() {
        self.addSubview(itemLabel)
        updateConstraints()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        itemLabel.easy.layout(
            Top(0),
            CenterX(0).to(self),
            Width(frame.width * 0.9),
            Height(frame.height)
        )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
