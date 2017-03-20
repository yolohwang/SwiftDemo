//
//  ViewController.swift
//  SwiftDemo09
//
//  Created by YoloHwang on 17/3/16.
//  Copyright © 2017年 Yolo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    fileprivate let items = ["2-Color", "Simple 2D Rotation", "Multicolor", "Multi Point Position", "BezierCurve Position",
                             "Color and Frame Change", "View Fade In", "Pop","Gaea"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
    }

    override func viewDidAppear(_ animated: Bool) {
        animation()
    }
    
    fileprivate func animation() {
        tableView.reloadData()
        
        let cells = tableView.visibleCells
        let tableHeight = tableView.bounds.size.height
        
        //UIView有CGAffineTransform类型的属性transform，它是定义在二维空间上完成View的平移，旋转，缩放等效果的实现。
        for cell in cells {
            cell.transform = CGAffineTransform (translationX: 0, y: tableHeight)
        }
        /*
        duration               表示动画执行时间。
        delay                  动画延迟时间。
        usingSpringWithDamping 表示弹性属性。
        initialSpringVelocity  初速度。
        options                可选项，一些可选的动画效果，包括重复等。
        animations             表示执行的动画内容，包括透明度的渐变，移动，缩放。
        completion             表示执行完动画后执行的内容。
         */
        var index = 0
        for cell in cells {
            UIView.animate(withDuration: 1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                cell.transform = CGAffineTransform (translationX: 0, y: 0)
            }, completion: nil)
            index += 1
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? DetailViewController {
            let cell = sender as? UITableViewCell
            let index = tableView.indexPath(for: cell!)
            detailVC.animationStr = items[(index?.row)!]
        }
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Basic Animations"
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
     
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
}
