//
//  AlarmListTableViewController.swift
//  myAlarm
//
//  Created by Hunter McNeil on 6/8/20.
//  Copyright © 2020 Hunter McNeil. All rights reserved.
//

import UIKit

class AlarmListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        AlarmController.shared.loadFromPersistenceStore()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AlarmController.shared.alarms.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "alarmCell", for: indexPath) as? SwitchTableViewCell else {return UITableViewCell()}

        let alarm = AlarmController.shared.alarms[indexPath.row]
        cell.delegate = self
        cell.updateViews(with: alarm)
        
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailView" {
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let destinationVC = segue.destination as? AlarmDetailTableViewController
            let selectedEntry = AlarmController.shared.alarms[indexPath.row]
            destinationVC?.alarm = selectedEntry
        }
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let alarms = AlarmController.shared.alarms
            let alarmToDelete = alarms[indexPath.row]
            AlarmController.shared.delete(alarm: alarmToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }     
    }
}
    extension AlarmListTableViewController: SwitchTableViewCellDelegate {
        func switchCellSwitchValueChanged(for cell: SwitchTableViewCell) {
            guard let indexPath = tableView.indexPath(for: cell) else {return}
            let settingToUpdate = AlarmController.shared.alarms[indexPath.row]
            AlarmController.toggleEnabled(alarm: settingToUpdate)
            cell.updateViews(with: settingToUpdate)
        }
}
