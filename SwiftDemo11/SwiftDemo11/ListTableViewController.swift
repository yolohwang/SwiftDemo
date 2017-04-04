//
//  ListTableViewController.swift
//  SwiftDemo11
//
//  Created by YoloHwang on 17/4/4.
//  Copyright © 2017年 Yolo. All rights reserved.
//

import UIKit

var personList = [Person]()

class ListTableViewController: UITableViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadDataSource { (list) in
            print(list)
            personList += list
            self.tableView.reloadData()
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? DetailViewController {
            //不通过delegate
           if let cell = sender as? UITableViewCell,
            let index = tableView.indexPath(for: cell) {
            detailVC.person = personList[index.row]
           }//通过delegate
           else if let index = sender as? IndexPath {
            detailVC.person = personList[index.row]
            detailVC.completionCallBack = {
                self.tableView.reloadRows(at: [index], with: .automatic)
            }
            }
           else {
            detailVC.completionCallBack = {
                guard let person = detailVC.person else {
                    return
                }
                personList.insert(person, at: 0)
                self.tableView.reloadData()
            }
            }
        }
    }
    @IBAction func addPersonAction(_ sender: Any) {
        performSegue(withIdentifier: "listDetail", sender: nil)
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath)
        cell.textLabel?.text = personList[indexPath.row].name
        cell.detailTextLabel?.text = personList[indexPath.row].phone
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "listDetail", sender: indexPath)
    }
}


