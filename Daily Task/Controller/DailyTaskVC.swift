//
//  DailyTask.swift
//  Daily Task
//
//  Created by MEHEDI.R8 on 11/6/18.
//  Copyright © 2018 R8soft. All rights reserved.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate


class DailyTaskVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var tasks: [DailyTask] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCoreDataObjects()
        tableView.reloadData()
    }
    
    func fetchCoreDataObjects() {
        self.fetch { (complete) in
            if tasks.count >= 1 {
                tableView.isHidden = false
            } else {
                tableView.isHidden = true
            }
        }
    }
    
    @IBAction func addBtnPressed(_ sender: Any) {
        guard let createTaskVC = storyboard?.instantiateViewController(withIdentifier: "TaskCreateVC") else {
            return
        }
        presentDetail(createTaskVC)
    }
}


extension DailyTaskVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell") as? TaskCell else {
            return UITableViewCell()
        }
        
        let task = tasks[indexPath.row]
        print(tasks)
        cell.configureCell(task: task)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexPath) in
            self.removeTask(atIndexPath: indexPath)
            self.fetchCoreDataObjects()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        let addAction = UITableViewRowAction(style: .normal, title: "ADD 1") { (rowAction, indexPath) in
            self.setProgress(atIndexPath: indexPath)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        deleteAction.backgroundColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        addAction.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        return [deleteAction, addAction]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension DailyTaskVC {
    
    func setProgress(atIndexPath indexpath: IndexPath ) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {
            return
        }
        
        let chosenTask = tasks[indexpath.row]
        
        if chosenTask.taskProgress < chosenTask.goalCompletionValue {
            chosenTask.taskProgress = chosenTask.taskProgress + 1
        } else {
            return
        }
        
        do {
            try managedContext.save()
        } catch {
            debugPrint("could not set progress\(error.localizedDescription)")
        }
    }
    
    func removeTask(atIndexPath indexpath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {
            return
        }
        
        managedContext.delete(tasks[indexpath.row])
        do {
            try managedContext.save()
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    func fetch(completion:(_ complete: Bool) ->()) {

        guard let managedContext = appDelegate?.persistentContainer.viewContext else {
            return
        }
        
        let fetchRequest = NSFetchRequest<DailyTask>(entityName: "DailyTask")
        
        do {
            tasks = try managedContext.fetch(fetchRequest)
            print("successfully fetch data")
            completion(true)
        } catch {
            debugPrint("Could not fetch:\(error.localizedDescription)")
        }
    }
}
