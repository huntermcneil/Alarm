//
//  AlarmController.swift
//  myAlarm
//
//  Created by Hunter McNeil on 6/8/20.
//  Copyright © 2020 Hunter McNeil. All rights reserved.
//

import Foundation

class AlarmController {
    static let shared = AlarmController()
    
    var alarms: [Alarm] = []

func addAlarm(fireDate: Date, name: String, enabled: Bool) {
    let newAlarm = Alarm(fireDate: fireDate, name: name, enabled: enabled)
    alarms.append(newAlarm)
    saveToPersistenceStore()
}

func update(alarm: Alarm, fireDate: Date, name: String, enabled: Bool) {
    alarm.fireDate = fireDate
    alarm.name = name
    alarm.enabled = enabled
    saveToPersistenceStore()
}

func delete(alarm: Alarm) {
    guard let index = alarms.firstIndex(of: alarm) else {return}
    alarms.remove(at: index)
    saveToPersistenceStore()
}
    
static func toggleEnabled(alarm: Alarm) {
        alarm.enabled = !alarm.enabled
    }
    
    //MARK: - Persistence
    func creatPersistenceStore() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("myAlarm.json") // <-- Change file (app) name
        return fileURL
    }
    
    // Save
    func saveToPersistenceStore() {
        let jsonEncoder = JSONEncoder()
        
        do {
            let data = try jsonEncoder.encode(alarms) // <-- Change S.O.T
            try data.write(to: creatPersistenceStore())
        } catch {
            print("Error encoding our alarms: \(error) -- \(error.localizedDescription)") // <-- Update error message
        }
    }
    
    // Load
    func loadFromPersistenceStore() {
        let jsonDecoder = JSONDecoder()
        
        do {
            let data = try Data(contentsOf: creatPersistenceStore())
            alarms = try jsonDecoder.decode([Alarm].self, from: data) // <-- Update S.O.T & Update the decoded Type
        } catch {
            print("Error decoding our data into alarms: \(error), \(error.localizedDescription)") // <-- Update error message
        }
    }
    
}

protocol AlarmScheduler {
   
    func scheduleUserNotifications(for alarm: Alarm)
    func cancelUserNotifications(for alarm: Alarm)
}
