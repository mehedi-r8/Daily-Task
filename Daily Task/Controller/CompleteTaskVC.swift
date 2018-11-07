//
//  CompleteTaskVC.swift
//  Daily Task
//
//  Created by MEHEDI.R8 on 11/7/18.
//  Copyright © 2018 R8soft. All rights reserved.
//

import UIKit
import CoreData

class CompleteTaskVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var pointsTextField: UITextField!
    @IBOutlet weak var createTaskBtn: UIButton!
    
    var taskName: String!
    var taskType: TaskType!
    
    func initData(task: String, type: TaskType) {
        self.taskName = task
        self.taskType = type
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pointsTextField.delegate = self
        hideKeyboard()
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        
    }
    
    @IBAction func createBtnPressed(_ sender: Any) {
        if pointsTextField.text != "" {
            save { (complete) in
                dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func hideKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(CompleteTaskVC.handleTap))
        view.addGestureRecognizer(tap)
    }
    
    //Handle Keyboard
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    
    //Saving coredata
    func save(completion: (_ finished: Bool) ->()) {
                
        guard let managaedContext = appDelegate?.persistentContainer.viewContext else {
            return
        }
        
        let task  = DailyTask(context: managaedContext)
        
        task.taskName = taskName
        task.taskType = taskType.rawValue
        task.taskProgress = Int32(pointsTextField.text!)!
        task.taskProgress = Int32(0)
        
        do {
            try managaedContext.save()
            print("Successfully save Data")
            completion(true)
        } catch {
            debugPrint("🥶🥶Could Not Save\(error.localizedDescription)")
            completion(false)
        }
    }
}
