//
//  Alarm.swift
//  myAlarm
//
//  Created by Hunter McNeil on 6/8/20.
//  Copyright © 2020 Hunter McNeil. All rights reserved.
//

import Foundation

class Alarm: Codable {
    var fireDate: Date
    var name: String
    var enabled: Bool
    var uuid: String

    
    init(fireDate: Date, name: String, enabled: Bool, uuid: String = UUID().uuidString) {
        self.fireDate = fireDate
        self.name = name
        self.enabled = enabled
        self.uuid = uuid
    }
}

extension Alarm: Equatable {
    static func == (lhs: Alarm, rhs: Alarm) -> Bool {
        return lhs.name == rhs.name && lhs.enabled == rhs.enabled && lhs.fireDate == rhs.fireDate && lhs.uuid == rhs.uuid
    }
}
