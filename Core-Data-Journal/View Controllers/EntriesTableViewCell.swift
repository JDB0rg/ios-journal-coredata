//
//  EntriesTableViewCell.swift
//  Core-Data-Journal
//
//  Created by Madison Waters on 11/5/18.
//  Copyright © 2018 Jonah Bergevin. All rights reserved.
//

import UIKit

class EntriesTableViewCell: UITableViewCell {

    @IBOutlet weak var entryTitleLabel: UILabel!
    @IBOutlet weak var entryBodyTextlabel: UILabel!
    @IBOutlet weak var entryTimestampLabel: UILabel!
    
    func updateViews() {
        
        guard let entry = entry else { return }
        
            entryTitleLabel.text = entry.title
            entryBodyTextlabel.text = entry.bodyText
        
        guard let timestamp = entry.timestamp else { return }
        
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            formatter.timeStyle = .short
            entryTimestampLabel.text = formatter.string(from: timestamp)
    }

    // MARK: - Properties
    
    var entry: Entry? {
        didSet{
            updateViews()
        }
    }
}
