//
//  AlarmDetailTableViewController.swift
//  myAlarm
//
//  Created by Hunter McNeil on 6/8/20.
//  Copyright © 2020 Hunter McNeil. All rights reserved.
//

import UIKit


class AlarmDetailTableViewController: UITableViewController {
    
    var alarm: Alarm?
    var alarmIsOn: Bool = true
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var alarmNameTextField: UITextField!
    @IBOutlet weak var enableButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        updateViews()
    }
    
    
    @IBAction func enableButtonTapped(_ sender: Any) {
        alarmIsOn = !alarmIsOn
    }
    @IBAction func saveButtonTapped(_ sender: Any) {
       guard let alarmName = alarmNameTextField.text else {return}
        
        let date = datePicker.date

        if let alarm = alarm {
           AlarmController.shared.update(alarm: alarm, fireDate: date, name: alarmName, enabled: alarmIsOn)
       } else {
           AlarmController.shared.addAlarm(fireDate: date, name: alarmName, enabled: alarmIsOn)
        }
        self.navigationController?.popViewController(animated: true)
        updateViews()

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }

        func updateViews() {

            guard let alarm = alarm else {
                enableButton.setTitle("ON", for: .normal)
                return }

            datePicker.date = alarm.fireDate
            alarmNameTextField.text = alarm.name

            if alarm.enabled {
                enableButton.setTitle("ON", for: .normal)
            } else {
                enableButton.setTitle("OFF", for: .normal)
            }
        }
        
    

    // MARK: - Table view data source

//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
//
//        // Configure the cell...
//
//        return cell
//    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
}
