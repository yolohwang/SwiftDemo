//
//  NewsTableViewController.swift
//  SwiftDemo06
//
//  Created by YoloHwang on 17/3/8.
//  Copyright © 2017年 Yolo. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {

    fileprivate let feedParser = FeedParser()//RSS解析
    fileprivate let feedURL = "http://www.apple.com/main/rss/hotnews/hotnews.rss"
    
    //字典
    //var dict = [Int: String](),dict1: [String:String] = ["":"","":""]
    //数组
    //var arr = [Int](), arr1: [String] = [""],arr2: [(title: String,description: String)] = []
    
    fileprivate var rssItems: [(title: String, description: String,pubDate: String)]?
    fileprivate var cellStates: [CellState]?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Apple News"
        
        tableView.estimatedRowHeight = 140
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.separatorStyle = .singleLine
       
        feedParser.parseFeed(feedURL: feedURL) { [weak self] rssItems in
            
            self?.rssItems = rssItems
            self?.cellStates = Array(repeating: .collapsed, count: rssItems.count)
        
            print(self?.rssItems ?? "rss nil")
            DispatchQueue.main.async {
                self?.tableView.reloadSections(IndexSet(integer: 0), with: .none)
//                self?.tableView.reloadData()
            }
        }
    }


    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let rssItems = rssItems else {
            let frame: CGRect = CGRect (x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height)
            let label = UILabel.init(frame: frame)
            label.text = "No Data"
            label.textAlignment = .center
            tableView.backgroundView = label
            tableView.separatorStyle = .none
            return 0
        }
        return rssItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsTableViewCell

        if let item = rssItems?[indexPath.row] {
            (cell.titleLabel.text,cell.contentLabel.text,cell.dateLabel.text) = (item.title,item.description,item.pubDate)
        }
        if let cellState = cellStates?[indexPath.row] {
            cell.contentLabel.numberOfLines = cellState == .expanded ? 0 : 4
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
     
        let cell = tableView.cellForRow(at: indexPath) as! NewsTableViewCell
        //beginUpdates本质上就是添加了一个动画事务，即CATransaction，当然这个事务可能包含许多操作，比如会重新调整每个cell的高度（但是默认不会重新加载所有的cell，当前点击的cell 会被重新加载）。如果你仅仅更改了UITableView的cell的样式，那么应该试试能否通过调用beginUpdates 和 reloadRowsAtIndexPaths 来实现效果，而不是调用tableview的reloadData方法去重新加载全部的cell！
        tableView.beginUpdates()
        cell.contentLabel.numberOfLines = cell.contentLabel.numberOfLines == 4 ? 0 : 4
        cellStates?[indexPath.row] = cell.contentLabel.numberOfLines == 4 ? .collapsed : .expanded
        tableView.endUpdates()
    }
}
