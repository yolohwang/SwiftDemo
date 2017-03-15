//
//  ArtistListTableViewController.swift
//  SwiftDemo04
//
//  Created by 黄永乐 on 17/3/2.
//  Copyright © 2017年 Yolo. All rights reserved.
//

import UIKit

class ArtistListTableViewController: UITableViewController {
    
    let artists = Artist.artistsFromBundle()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 140
       
        
        

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ArtistDetailTableViewController,
           let indexpath = self.tableView.indexPathForSelectedRow {
        destination.selectedArist = artists[indexpath.row]
        }
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 166.0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artists.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArtistCell", for: indexPath) as! ArtistTableViewCell
        let artist = artists[indexPath.row]
        
        cell.bioLabel.text = artist.bio
        cell.bioLabel.textColor = UIColor (white: 114/255, alpha: 1.0)
        cell.bioLabel.font =  UIFont.preferredFont(forTextStyle: .body)
        cell.bioLabel.numberOfLines = 0
        cell.artistImageView.image = artist.image
        
        cell.nameLabel.text = artist.name
        cell.nameLabel.backgroundColor = UIColor (red: 1, green: 152/255, blue: 0, alpha: 1.0)
        cell.nameLabel.textColor =  UIColor.white
        cell.nameLabel.textAlignment = .center
        cell.nameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        
        cell.selectionStyle = .none
        
        
        return cell
    }
    
    
    
    
    
    
    
    
    
    
}
