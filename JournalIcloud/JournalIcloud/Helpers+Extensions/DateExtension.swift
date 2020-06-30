//
//  DateExtension.swift
//  JournalIcloud
//
//  Created by Connor Holland on 6/29/20.
//  Copyright © 2020 Connor Holland. All rights reserved.
//

import Foundation

extension Date {
    
    func dateAsString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        
        return formatter.string(from: self)
    }
}
