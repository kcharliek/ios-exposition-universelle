//
//  EntryTableViewController.swift
//  Expo1900
//
//  Created by duckbok on 2021/04/15.
//

import UIKit

class EntryTableViewController: UITableViewController {
    var entries: [Exposition.Entry]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        entries = try? JSONParser<[Exposition.Entry]>.parse("items").get()
        navigationItem.title = "한국의 출품작"
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
        guard let entryCell: EntryTableViewCell = cell as? EntryTableViewCell else { return cell }
        guard let entries: [Exposition.Entry] = entries else { return cell }
        
        entryCell.putEntryData(from: entries[indexPath.row])
        
        return entryCell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let entryViewController = storyboard?.instantiateViewController(identifier: "EntryViewController") as? EntryViewController {
            entryViewController.entry = entries?[indexPath.row]
            
            navigationController?.pushViewController(entryViewController, animated: true)
        }
    }
}