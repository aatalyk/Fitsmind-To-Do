//
//  DatePickerView.swift
//  Fitsmind To-Do
//
//  Created by Atalyk Akash on 11/21/17.
//  Copyright © 2017 Atalyk Akash. All rights reserved.
//

import UIKit
import EasyPeasy

class DatePickerView: BaseView {

    lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        return picker
    }()
    
    override func setup() {
        self.addSubview(datePicker)
        updateConstraints()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        datePicker.easy.layout(Edges())
    }

}
