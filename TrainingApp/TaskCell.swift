//
//  TaskCell.swift
//  TrainingApp
//
//  Created by Igor Sapyanik on 28.02.16.
//  Copyright © 2016 Kinvey. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {

    @IBOutlet weak var actionLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var completeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
