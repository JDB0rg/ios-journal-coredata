//
//  EntryDetailViewController.swift
//  Core-Data-Journal
//
//  Created by Madison Waters on 11/5/18.
//  Copyright © 2018 Jonah Bergevin. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }

    // MARK: - Properties
    
    var entry: Entry? {
        didSet{
            updateViews()
        }
    }
    
    var entryController: EntryController?
    
    // MARK: - Outlets & Actions
    
    @IBOutlet weak var addEntryTitleTextField: UITextField!
    @IBOutlet weak var addEntryBodyTextView: UITextView!
    @IBOutlet weak var entryDateLabel: UILabel!
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        guard let title = addEntryTitleTextField.text,
            let bodyText = addEntryBodyTextView.text,
            let timestamp = entryDateLabel.text,
            !title.isEmpty else { return }
        
        if let updateEntry = entry {
            
            updateEntry.title = title
            updateEntry.bodyText = bodyText
            
            entryController?.updateEntry(entry: updateEntry, title: title, bodyText: bodyText)
            
        } else {
            let newEntry = Entry(context: CoreDataStack.shared.mainContext)
            newEntry.title = title
            newEntry.bodyText = bodyText
        }
            do {
                try CoreDataStack.shared.mainContext.save()
                
                navigationController?.popViewController(animated: true)
                
            } catch {
                print("Failed to save: \(error)")
            }
            entryController?.createEntry(title: title, bodyText: bodyText)
    }
    
    // MARK: - Update Views Method
    
    private func updateViews() {
        guard let entry = entry,
            isViewLoaded,
            let timestamp = entry.timestamp else { return }
        
        title = entry.title ?? "Create New Entry"
        
        addEntryTitleTextField.text = entry.title
        addEntryBodyTextView.text = entry.bodyText
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        entryDateLabel.text = formatter.string(from: timestamp)
        
    }
    
}
