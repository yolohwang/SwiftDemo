//
//  DetailViewController.swift
//  SwiftDemo11
//
//  Created by YoloHwang on 17/4/4.
//  Copyright © 2017年 Yolo. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {

    var person: Person?
    var completionCallBack: (()->())?
    
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let person = person {
            updateUI(person)
            title = "编辑联系人"
        } else {
            title = "添加联系人"
        }
        
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        if !(nameTF.text?.isEmpty)!,
           !(phoneTF.text?.isEmpty)!,
           !(titleTF.text?.isEmpty)! {
            
            if person == nil {
                person = Person()
            }
            
            person?.name = nameTF.text
            person?.phone = phoneTF.text
            person?.title = titleTF.text
            
            completionCallBack?()
            _ = navigationController?.popViewController(animated: true)
        }
    }
    private func updateUI(_ person: Person) {
        nameTF.text = person.name
        phoneTF.text = person.phone
        titleTF.text = person.title
    }
}
