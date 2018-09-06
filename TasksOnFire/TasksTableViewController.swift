//
//  TasksTableViewController.swift
//  TasksOnFire
//
//  Created by Soon Yin Jie on 5/9/18.
//  Copyright © 2018 Tinkertanker. All rights reserved.
//

import UIKit
import Firebase

class TasksTableViewController: UITableViewController {
    
    var tasks: [Task] = []
    let db = Database.database().reference(withPath: "tasks")

    override func viewDidLoad() {
        super.viewDidLoad()
        db.observe(.value) { (snapshot) in
            
            var newTasks: [Task] = []
            
            print(snapshot)
            // Now to update newTasks with all the children of snapshot
            
            for childSnapshot in snapshot.children {
                if let childSnapshot = childSnapshot as? DataSnapshot,
                let taskDict = childSnapshot.value as? [String: AnyObject],
                let name = taskDict["name"] as? String,
                let completed = taskDict["completed"] as? Bool,
                let addedByUser = taskDict["addedByUser"] as? String {
                    let newTask = Task(name: name, completed: completed, addedByUser: addedByUser)
                    newTasks.append(newTask)
                }
                
            }
            
            self.tasks = newTasks
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)

        cell.textLabel?.text = tasks[indexPath.row].name
        cell.detailTextLabel?.text = tasks[indexPath.row].addedByUser

        return cell
    }
    
    @IBAction func addTask(_ sender: Any) {
        let alert = UIAlertController(title: "Add task", message: "", preferredStyle: .alert)
        alert.addTextField()
        let confirmAction = UIAlertAction(title: "Add", style: .default) { (_) in
            let textField = alert.textFields![0]
            let task = Task(name: textField.text ?? "", completed: false, addedByUser: "kopitiamuncle@icloud.com")
            
            let taskRef = self.db.child(task.name)
            taskRef.setValue(task.toDictionary())
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
