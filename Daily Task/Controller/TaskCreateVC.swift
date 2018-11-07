//
//  TaskCreateVC.swift
//  Daily Task
//
//  Created by MEHEDI.R8 on 11/7/18.
//  Copyright © 2018 R8soft. All rights reserved.
//

import UIKit

class TaskCreateVC: UIViewController, UITextViewDelegate {

    @IBOutlet weak var taskTxt: UITextView!
    @IBOutlet weak var priorityHighBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var priorityLowBtn: UIButton!
    
    var tasktype: TaskType = .low
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskTxt.delegate = self
        nextBtn.KeyboardBind()
        priorityLowBtn.setSelectedColor()
        priorityHighBtn.setDeselectedColor()
    }
    
    @IBAction func highBtnPressed(_ sender: Any) {
        tasktype = .high
        priorityHighBtn.setSelectedColor()
        priorityLowBtn.setDeselectedColor()
    }
    
    @IBAction func lowbtnPressed(_ sender: Any) {
        tasktype = .low
        priorityLowBtn.setSelectedColor()
        priorityHighBtn.setDeselectedColor()
    }
    
    @IBAction func nextBtnPressed(_ sender: Any) {
        if taskTxt.text != "" && taskTxt.text != "What is your Task?"{
            guard let completeTaskVC = storyboard?.instantiateViewController(withIdentifier: "CompleteTaskVC") as? CompleteTaskVC else {
                return
            }
            completeTaskVC.initData(task: taskTxt.text!, type: tasktype)
            //presentDetail(completeTaskVC)
            presentingViewController?.presentSecondaryDetails(completeTaskVC)
        }
    }
    
    @IBAction func BackBtnPressed(_ sender: Any) {
        dismissDetail()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        taskTxt.text = ""
    }
}
