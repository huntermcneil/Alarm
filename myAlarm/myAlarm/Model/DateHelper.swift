//
//  DateHelper.swift
//  myAlarm
//
//  Created by Hunter McNeil on 6/10/20.
//  Copyright © 2020 Hunter McNeil. All rights reserved.
//

import Foundation

extension Date {
    
    func formatAsString() -> String {
        let dateFormatter = DateFormatter()
          dateFormatter.dateStyle = DateFormatter.Style.short
          dateFormatter.timeStyle = DateFormatter.Style.short
        return dateFormatter.string(from: self)
    }
}
