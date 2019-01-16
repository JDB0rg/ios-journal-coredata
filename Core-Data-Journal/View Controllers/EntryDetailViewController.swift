//
//  EntryDetailViewController.swift
//  Core-Data-Journal
//
//  Created by Madison Waters on 11/5/18.
//  Copyright © 2018 Jonah Bergevin. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var entry: Entry? {
        didSet{ updateViews() }
    }
    
    var entryController: EntryController?
    
    // MARK: - Outlets
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var addEntryTitleTextField: UITextField!
    @IBOutlet weak var moodSegmentedControl: UISegmentedControl!
    @IBOutlet weak var addEntryBodyTextView: UITextView!
    @IBOutlet weak var entryDateLabel: UILabel!
    
    // MARK: - Update Views Method
    private func updateViews() {
        guard isViewLoaded,
            let timestamp = entry?.timestamp else { return }
        
        if let entry = entry {
        addEntryTitleTextField.text = entry.title
        addEntryBodyTextView.text = entry.bodyText
        title = entry.title ?? "Create New Entry"
        
        let mood = entry.entryMood
        let moodIndex = EntryMood.allCases.index(of: mood)!
        moodSegmentedControl.selectedSegmentIndex = moodIndex
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        entryDateLabel.text = formatter.string(from: timestamp)
        }
    }

    // MARK: - Actions
    @IBAction func nameChanged(_ sender: UITextField) {
        let currentName = sender.text ?? ""
        let hasAName = (currentName.isEmpty == false)
        saveButton.isEnabled = hasAName
    }

    @IBAction func saveButtonTapped(_ sender: Any) {
        
        guard let title = addEntryTitleTextField.text,
            let bodyText = addEntryBodyTextView.text,
            let timestamp = entryDateLabel.text,
            !title.isEmpty else { return }
        
        if let updateEntry = entry {
            
            updateEntry.title = title
            updateEntry.bodyText = bodyText
            
            let moodIndex = moodSegmentedControl.selectedSegmentIndex
            updateEntry.entryMood = EntryMood.allCases[moodIndex]
            
            entryController?.updateEntry(entry: updateEntry, title: title, bodyText: bodyText, mood: updateEntry.entryMood.rawValue)
            
        } else {
            
            let newEntry = Entry(context: CoreDataStack.shared.mainContext)
            newEntry.title = title
            newEntry.bodyText = bodyText
            
            let moodIndex = moodSegmentedControl.selectedSegmentIndex
            newEntry.entryMood = EntryMood.allCases[moodIndex]
            
            entryController?.createEntry(title: title, bodyText: bodyText, mood: newEntry.entryMood.rawValue)
        }
            do {
                try CoreDataStack.shared.mainContext.save()
                navigationController?.popViewController(animated: true)
            } catch {
                print("Failed to save: \(error)")
            }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
}
