//
//  EntriesTableViewController.swift
//  Core-Data-Journal
//
//  Created by Madison Waters on 11/5/18.
//  Copyright © 2018 Jonah Bergevin. All rights reserved.
//

import UIKit
import CoreData

class EntriesTableViewController: UITableViewController {

    var entries: [Entry] {
        let fetchRequest: NSFetchRequest<Entry> = Entry.fetchRequest()
        let results = (try? CoreDataStack.shared.mainContext.fetch(fetchRequest)) ?? []
        return results
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
            tableView.reloadData()
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return entries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EntryCell", for: indexPath) as? EntriesTableViewCell else {
            fatalError("Error dequeueing cell")
        }

        let entry = entries[indexPath.row]
        
        cell.entryTitleLabel?.text = entry.title
        cell.entryBodyTextlabel?.text = entry.bodyText
        //cell.entryTimestampLabel?.text =
        
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let entry = entries[indexPath.row]
            let moc = CoreDataStack.shared.mainContext
            moc.delete(entry)
            
            do {
                try moc.save()
            } catch {
                NSLog("Error saving deletion to managed object context: \(error)")
                moc.reset()
            }
            tableView.reloadData()
        }
    }
        
    // MARK: - Navigation // addJournalEntry // EditJournalEntry

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditJournalEntry" {
            let detailVC = segue.destination as! EntryDetailViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                detailVC.entry = entries[indexPath.row]
            }
        }
    }
    
    // MARK: - Properties
    
    let entryController = EntryController()
}
