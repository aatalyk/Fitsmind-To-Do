//
//  Extensions.swift
//  Fitsmind To-Do
//
//  Created by Atalyk Akash on 11/21/17.
//  Copyright © 2017 Atalyk Akash. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array: [T] = []
        for i in 0..<count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }
        return array
    }
}

extension UIFont {
    
    static let customRegular: UIFont = {
        let font = UIFont(name: "Helvetica", size: 18)
        return font!
    }()
    
    static let customBold: UIFont = {
        let font = UIFont(name: "Helvetica-Bold", size: 18)
        return font!
    }()
}

extension Date {
    static func getDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd"
        let dateString = dateFormatter.string(from: Date())
        return dateString
    }
}

extension UIColor {
    static let mainColor: UIColor = {
        let color = UIColor(red: 26.0/255.0, green: 188.0/255.0, blue: 156.0/255.0, alpha: 1)
        return color
    }()
}

