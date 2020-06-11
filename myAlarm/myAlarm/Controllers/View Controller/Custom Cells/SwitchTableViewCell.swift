//
//  SwitchTableViewCell.swift
//  myAlarm
//
//  Created by Hunter McNeil on 6/8/20.
//  Copyright © 2020 Hunter McNeil. All rights reserved.
//

import UIKit

protocol SwitchTableViewCellDelegate: AnyObject {
    func switchCellSwitchValueChanged(for cell:SwitchTableViewCell)
}

class SwitchTableViewCell: UITableViewCell {
    //MARK: - Outlets
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    weak var delegate: SwitchTableViewCellDelegate?
    
    //MARK: - Actions
    @IBAction func switchValueChanged(_ sender: Any) {
    }
    
    
    var alarm: Alarm?
    
    func updateViews(with alarm: Alarm) {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        let dateTime = formatter.string(for: AlarmController.shared.alarms)
        guard dateTime != nil else {return}
        
        timeLabel.text = dateTime
        nameLabel.text = alarm.name
        alarmSwitch.isOn = alarm.enabled
    }
}
