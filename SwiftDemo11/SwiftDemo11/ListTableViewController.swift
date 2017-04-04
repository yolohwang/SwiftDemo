//
//  ListTableViewController.swift
//  SwiftDemo11
//
//  Created by YoloHwang on 17/4/4.
//  Copyright © 2017年 Yolo. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {

    var personList = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDataSource { (list) in
            print(list)
        }

    }
    
    private func loadDataSource(completion:@escaping (_ list: [Person])->())->() {
        DispatchQueue.global().async {
            var arrayM = [Person]()
            for i in 0...20 {
                let p = Person()
                p.name = "hwang - \(i)"
                p.phone = "1860" + String (format: "%06d", arc4random_uniform(1000000))
                p.title = "Programmer"
                
                arrayM.append(p)
            }
            
            DispatchQueue.main.async(execute: {
                completion(arrayM)
            })
        }
    }
}

extension ListTableViewController {
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

}
