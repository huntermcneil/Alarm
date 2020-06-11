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
    
    
    var alarm: Alarm? {
    didSet{
       updateViews()
    }
    }
    
    
    //MARK: - Outlets
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    weak var delegate: SwitchTableViewCellDelegate?
    
    //MARK: - Actions
    @IBAction func switchValueChanged(_ sender: Any) {
        delegate?.switchCellSwitchValueChanged(for: self)
    }
    

    
    func updateViews() {
        
        guard let alarm = alarm else {return}
  
        timeLabel.text = alarm.fireTimeAsString
        nameLabel.text = alarm.name
        alarmSwitch.isOn = alarm.enabled
    }
}
