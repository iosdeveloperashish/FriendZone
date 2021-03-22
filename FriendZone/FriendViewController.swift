//
//  FriendViewController.swift
//  FriendZone
//
//  Created by Ashish Viltoriya on 02/03/21.
//

import UIKit

class FriendViewController: UITableViewController, Storyboarded {

    weak var coordinator: MainCoordinator?
    
    var friend: Friend!
    var timezones = [TimeZone]()
    var selectedTimezone = 0
    
    var nameEditingCell: TextTableViewCell? {
        let indexPath = IndexPath(row: 0, section: 0)
        return tableView.cellForRow(at: indexPath) as? TextTableViewCell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let identifiers = TimeZone.knownTimeZoneIdentifiers
        for identifier in identifiers {
            if let timeZone = TimeZone(identifier: identifier) {
                timezones.append(timeZone)
            }
        }
        
        self.selectedTimezone = timezones.firstIndex(of: friend.timezone) ?? 0
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        coordinator?.update(friend: friend)
    }
    
    @IBAction func nameChanged(_ sender: UITextField) {
        friend.name = sender.text ?? "" 
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return timezones.count
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Name their friend"
        } else {
            return "Select their Timezone"
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "name", for: indexPath) as? TextTableViewCell else {
                fatalError("Could not be able to load")
            }
            cell.textField.text = friend.name
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TimeZone", for: indexPath)
            let timeZone = timezones[indexPath.row]
            cell.textLabel?.text = timeZone.identifier.replacingOccurrences(of: "_", with: "  ")
            let timeDifference = timeZone.secondsFromGMT(for: Date())
            cell.detailTextLabel?.text = timeDifference.timeString()
            
            if indexPath.row == selectedTimezone {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            startEditingName()
        } else {
            selectRow(at: indexPath)
        }
    }
    
    func startEditingName() {
        nameEditingCell?.textField.becomeFirstResponder()
    }
    
    func selectRow(at indexPath: IndexPath) {
        nameEditingCell?.textField.resignFirstResponder()
        
        for cell in tableView.visibleCells {
            cell.accessoryType = .none
        }
        selectedTimezone = indexPath.row
        
        friend.timezone = timezones[indexPath.row]
        
        let selected = tableView.cellForRow(at: indexPath)
        selected?.accessoryType = .checkmark
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}
