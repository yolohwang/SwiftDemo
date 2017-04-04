//
//  DetailViewController.swift
//  SwiftDemo03
//
//  Created by 黄永乐 on 17/3/1.
//  Copyright © 2017年 Yolo. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var childButton: UIButton!
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var shoppingCartButton: UIButton!
    @IBOutlet weak var travelButton: UIButton!
    @IBOutlet weak var todoListTextField: UITextField!
    @IBOutlet weak var todoDatePicker: UIDatePicker!
    
    
    var todo: TodoItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if todo == nil {
            self.title = "New Todo"
            childButton.isSelected = true
        } else {
            self.title = "Edit Todo"
            if todo?.image == "child-selected" {
                childButton.isSelected = true
            }
            else if todo?.image == "phone-selected" {
                phoneButton.isSelected = true
            }
            else if todo?.image == "shoping-cart-selected" {
                shoppingCartButton.isSelected = true
            }
            else if todo?.image == "travel-selected" {
                travelButton.isSelected = true
            }
            
            todoListTextField.text = todo?.title
            todoDatePicker.setDate((todo?.date)! as Date, animated: true)
        }

    }

    @IBAction func selectChild(_ sender: Any) {
        resetButton()
        childButton.isSelected = true
    }
    
    @IBAction func selectPhone(_ sender: Any) {
        resetButton()
        phoneButton.isSelected = true
    }

    @IBAction func selectShoppingCart(_ sender: Any) {
        resetButton()
        shoppingCartButton.isSelected = true
    }
    
    @IBAction func selectTravel(_ sender: Any) {
        resetButton()
        travelButton.isSelected = true

    }

    @IBAction func tapDone(_ sender: Any) {
        var image = ""
        if childButton.isSelected {
            image = "child-selected"
        }
        else if phoneButton.isSelected {
            image = "phone-selected"
        }
        else if shoppingCartButton.isSelected {
            image = "shoping-cart-selected"
        }
        else if travelButton.isSelected {
            image = "travel-selected"
        }
        if todo == nil {
            let uuid = UUID().uuidString
            todo = TodoItem (id: uuid, image: image, title: todoListTextField.text!, date: todoDatePicker.date)
            todos.append(todo!)
        } else {
            todo?.title = todoListTextField.text!
            todo?.image = image
            todo?.date = todoDatePicker.date
            
        }
//        navigationController?.popViewController(animated: true)
//        navigationController?.popToRootViewController(animated: true)
    }
    
    fileprivate func resetButton (){
        childButton.isSelected = false
        phoneButton.isSelected = false
        shoppingCartButton.isSelected = false
        
    }
    
    
}
