//
//  DateExtension.swift
//  Task-CoreData
//
//  Created by Rozalia Rodichev on 7/28/21.
//

import Foundation

extension Date {
    
    func formatToString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        
        return formatter.string(from: self)
    }
}//End of extension
