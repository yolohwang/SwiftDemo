//
//  TodoListTableViewController.swift
//  SwiftDemo03
//
//  Created by 黄永乐 on 17/2/20.
//  Copyright © 2017年 Yolo. All rights reserved.
//

import UIKit

var todos:[TodoItem] = []

class TodoListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = editButtonItem
        
        todos = [TodoItem (id: "1", image: "child-selected", title: "Go to disney", date: dateFromSting("2017-10-20")!),
                 TodoItem (id: "2", image: "shoping-cart-selected", title: "Go to disney", date: dateFromSting("2017-10-20")!),
                 TodoItem (id: "3", image: "phone-selected", title: "Phone to Jobs", date: dateFromSting("2117-10-20")!),
                 TodoItem (id: "4", image: "travel-selected", title: "Plan to Europe", date: dateFromSting("2017-10-20")!)]
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }


    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 83
    }

     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if todos.count != 0 {
            return todos.count
        } else {
            let messageLabel = UILabel()
            
            setMessageLabel(messageLabel, frame: CGRect (x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height), text: "No data available.", textColor: .black, numberOfLines: 0, textAlignment: .center, font: UIFont(name: "Palatino-Italic", size: 20)!)
            tableView.backgroundView = messageLabel
            tableView.separatorStyle = .none
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)

        setCellWithTodoItem(cell, todoItem: todos[indexPath.row])

        return cell
    }
    
    
    //edit mode
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.tableView.setEditing(editing, animated: true)
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todos.remove(at: (indexPath as NSIndexPath).row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return tableView.isEditing
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let todo = todos.remove(at: (sourceIndexPath as NSIndexPath).row)
        todos.insert(todo, at: (destinationIndexPath as NSIndexPath).row)
    }


    // MARK: Helper Func
    
    fileprivate func setMessageLabel(_ messageLabel: UILabel,frame: CGRect,text: String,textColor: UIColor,numberOfLines: Int,textAlignment: NSTextAlignment,font: UIFont) {
        messageLabel.frame = frame
        messageLabel.text = text
        messageLabel.textColor = textColor
        messageLabel.numberOfLines = numberOfLines
        messageLabel.textAlignment = textAlignment
        messageLabel.font = font
    }
    
    fileprivate func setCellWithTodoItem(_ cell: UITableViewCell, todoItem: TodoItem) {
        let imageV: UIImageView = cell.viewWithTag(11) as! UIImageView
        let titelLabel: UILabel = cell.viewWithTag(12) as! UILabel
        let dateLabel: UILabel = cell.viewWithTag(13) as! UILabel
        
        imageV.image = UIImage(named: todoItem.image)
        titelLabel.text = todoItem.title
        dateLabel.text = stringFromDate(todoItem.date)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editTodo" {
            let vc = segue.destination as! DetailViewController
            let indexPath = self.tableView.indexPathForSelectedRow
            if let indexPath = indexPath {
                vc.todo = todos[(indexPath as NSIndexPath).row]
            }
        }
    }
    
    @IBAction func unwindTapButton(_ segue: UIStoryboardSegue) {
    
        if segue.identifier == "tapButton" {
            let detailVC = segue.source as? DetailViewController
            var image = ""
            
            if (detailVC?.childButton.isSelected)! {
                image = "child-selected"
            }
            else if (detailVC?.phoneButton.isSelected)! {
                image = "phone-selected"
            }
            else if (detailVC?.shoppingCartButton.isSelected)! {
                image = "shoping-cart-selected"
            }
            else if (detailVC?.travelButton.isSelected)! {
                image = "travel-selected"
            }
            if let todo = detailVC?.todo  {
                todo.title = (detailVC?.todoListTextField.text)!
                todo.image = image
                todo.date = (detailVC?.todoDatePicker.date)!
            } else {
                let todo = TodoItem (id: UUID().uuidString, image: image, title: (detailVC?.todoListTextField.text)!, date: (detailVC?.todoDatePicker.date)!)
                todos.append(todo)
            }
            
            
        }
    }
    
    

}
