//
//  ViewController.swift
//  FriendZone
//
//  Created by Ashish Viltoriya on 02/03/21.
//

import UIKit

class ViewController: UITableViewController, Storyboarded {

    weak var coordinator: MainCoordinator?
    
    var friends = [Friend]()
    var selectedFriend: Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        title = "Friend Zone"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFriend))
    }
    
    @objc func addFriend() {
        let friend = Friend()
        friends.append(friend)
        tableView.insertRows(at: [IndexPath(row: friends.count - 1, section: 0)], with: .automatic)
        saveData()
        selectedFriend = friends.count - 1
        coordinator?.configure(friend: friend)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let friend = friends[indexPath.row]
        cell.textLabel?.text = friend.name
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = friend.timezone
        dateFormatter.timeStyle = .short
        
        
        cell.detailTextLabel?.text = dateFormatter.string(from: Date())
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedFriend = indexPath.row
        coordinator?.configure(friend: friends[indexPath.row])
    }
    
    func loadData() {
        let defaults = UserDefaults.standard
        
        guard let savedData = defaults.data(forKey: "friends") else {
            return
        }
        let decoder = JSONDecoder()
        guard let savedFriends = try? decoder.decode([Friend].self, from: savedData) else { return }
        
        self.friends = savedFriends
    }
    
    func saveData() {
        let defaults = UserDefaults.standard
        let encoder = JSONEncoder()
        guard let saveData = try? encoder.encode(friends) else { return }
        defaults.setValue(saveData, forKey: "friends")
    }
    
    func updateFriend(friend: Friend) {
        guard let selectedFriend = selectedFriend else { return }
        friends[selectedFriend] = friend
        tableView.reloadData()
        saveData()
    }
}

