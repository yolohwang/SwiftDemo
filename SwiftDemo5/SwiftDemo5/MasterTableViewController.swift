//
//  MasterTableViewController.swift
//  SwiftDemo5
//
//  Created by YoloHwang on 17/3/6.
//  Copyright © 2017年 Yolo. All rights reserved.
//

import UIKit

class MasterTableViewController: UITableViewController {

    
    // MARK: - Properties
    var detailVC: DetailViewController? = nil
    var candies = [Candy]()
    var filteredCandies = [Candy]()
    let searchController = UISearchController (searchResultsController: nil)
    
    //MARK: - View Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let att = [NSForegroundColorAttributeName:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = att
//        navigationController?.navigationBar.backgroundColor = UIColor.candyColor()
        navigationController?.navigationBar.barTintColor = UIColor.candyColor()

        candies = [Candy(category:"Chocolate", name:"Chocolate Bar"),
                   Candy(category:"Chocolate", name:"Chocolate Chip"),
                   Candy(category:"Chocolate", name:"Dark Chocolate"),
                   Candy(category:"Hard", name:"Lollipop"),
                   Candy(category:"Hard", name:"Candy Cane"),
                   Candy(category:"Hard", name:"Jaw Breaker"),
                   Candy(category:"Other", name:"Caramel"),
                   Candy(category:"Other", name:"Sour Chew"),
                   Candy(category:"Other", name:"Gummi Bear")]
        
        setupSearchController()
        
        if let splitViewController = splitViewController {
            let controllers = splitViewController.viewControllers
            detailVC = (controllers[controllers.count - 1] as! UINavigationController).topViewController as? DetailViewController
        }

    }

    
    // MARK: - Search Controller Setup
    fileprivate func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        //当搜索框弹出时是否覆盖当前的视图控制器
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.scopeButtonTitles = ["All","Chocolate","Hard"]
        searchController.searchBar.delegate = self
        //禁止搜索框编辑时上移
        searchController.hidesNavigationBarDuringPresentation = false
    }
    
    fileprivate func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredCandies = candies.filter({ candy in
            let categoryMatch = (scope == "All") || (candy.category == scope)
            return categoryMatch && candy.name.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredCandies.count
        }
        return candies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MasterCell", for: indexPath)

        let candy: Candy
        if searchController.isActive && searchController.searchBar.text != "" {
            candy = filteredCandies[indexPath.row]
        } else {
            candy = candies[indexPath.row]
        }
        cell.textLabel?.text = candy.name
        cell.detailTextLabel?.text = candy.category

        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let  candy: Candy
                if searchController.isActive && searchController.searchBar.text != "" {
                    candy = filteredCandies[indexPath.row]
                } else {
                    candy = candies[indexPath.row]
                }
                
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailCandy = candy
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
                
                //let vc = segue.destination as! DetailViewController
                
                
                
            }
        }
    }

}

//编辑时会调用
extension MasterTableViewController: UISearchResultsUpdating {
 
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
        
    }
}
//选择scopeButton时调用
extension MasterTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        
        filterContentForSearchText(searchBar.text!, scope: scope)
    }
}


