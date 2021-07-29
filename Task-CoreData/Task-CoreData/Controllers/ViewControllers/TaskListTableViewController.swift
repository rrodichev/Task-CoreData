//
//  TaskListTableViewController.swift
//  Task-CoreData
//
//  Created by Rozalia Rodichev on 7/27/21.
//

import UIKit

class TaskListTableViewController: UITableViewController {

    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        CoreDataStack.saveContext()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        TaskController.shared.fetchTasks()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskController.shared.tasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskTableViewCell

        let task = TaskController.shared.tasks[indexPath.row]
        
        cell.taskNameLabel.text = task.name
        cell.taskDueDateLabel.text = task.dueDate?.formatToString()
        cell.delegate = self

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let taskToDelete = TaskController.shared.tasks[indexPath.row]
            TaskController.shared.delete(task: taskToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destinationVC = segue.destination as? TaskDetailViewController else { return }
            
            let taskToSend = TaskController.shared.tasks[indexPath.row]
            destinationVC.task = taskToSend
        }
    }
}
// Extensions
extension TaskListTableViewController: TaskCompletionDelegate {
    
    func taskCellButtomTapped(_ sender: TaskTableViewCell) {
        
        guard let indexPath = tableView.indexPath(for: sender) else { return  }
        
        let task = TaskController.shared.tasks[indexPath.row]
        TaskController.shared.toggleIsComplete(task: task)
        
        sender.updateViews(with: task)
    }
}//End of extension

