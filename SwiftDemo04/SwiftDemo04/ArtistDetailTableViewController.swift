//
//  ArtistDetailTableViewController.swift
//  SwiftDemo04
//
//  Created by 黄永乐 on 17/3/4.
//  Copyright © 2017年 Yolo. All rights reserved.
//

import UIKit

class ArtistDetailTableViewController: UITableViewController {

    var selectedArist: Artist!
    let moreInfoText = "select For More Info"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = selectedArist.name
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 300
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedArist.works.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! ArtistDetailTableViewCell
        let work = selectedArist.works[indexPath.row]
        
        cell.workTitleLable.text = work.title
        cell.workImageView.image = work.image
        cell.moreInfoTextView.text = work.isExpanded ? work.info : moreInfoText
        cell.moreInfoTextView.textAlignment = work.isExpanded ? .left : .center


        return cell
    }
 

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? ArtistDetailTableViewCell else {
            return
        }
        
        var work = selectedArist.works[indexPath.row]
        
        work.isExpanded = !work.isExpanded
        selectedArist.works[indexPath.row] = work
        
        cell.moreInfoTextView.text = work.isExpanded ? work.info : moreInfoText
        cell.moreInfoTextView.textAlignment = work.isExpanded ? .left : .center
        tableView.beginUpdates()
        tableView.endUpdates()
        
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)

        
    }
}
