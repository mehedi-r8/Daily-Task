//
//  TaskCell.swift
//  Daily Task
//
//  Created by MEHEDI.R8 on 11/6/18.
//  Copyright © 2018 R8soft. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {
        
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var taskProgress: UILabel!
    @IBOutlet weak var completeLbl: UILabel!
    @IBOutlet weak var completeView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureCell(task: DailyTask) {
        self.taskLabel.text = task.taskName
        self.typeLabel.text = task.taskType
        self.taskProgress.text = String(task.taskProgress)
        
        if task.taskProgress == task.goalCompletionValue {
            self.completeLbl.text = "👌🏻"
        } else {
            self.completeLbl.text = ""
        }
    }
}
