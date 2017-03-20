//
//  HomeViewController.swift
//  SwiftDemo08
//
//  Created by YoloHwang on 17/3/15.
//  Copyright © 2017年 Yolo. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var bgImageView: UIVisualEffectView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate let interests = Interest.createInterests()
    
    fileprivate struct Storyboard {
        static let cellIndetifier = "Interest Cell"
    }
    

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let imageViewController = segue.destination as? ImageViewController {
            
            /*1.*/
            let point: CGPoint = view.convert(collectionView.center, to: collectionView)
            let index: IndexPath = collectionView.indexPathForItem(at: point)!
            /*2.*/
            let index1: IndexPath = collectionView.indexPathsForSelectedItems![0]
            /*3.*/
            let cell = sender as? UICollectionViewCell
            let index2: IndexPath = collectionView.indexPath(for: cell!)!
    
            print(index.item,index1.item,index2.item)
            
            imageViewController.bigImage = interests[index.item].featureImage
        }
    }
    
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interests.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath:
        IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.cellIndetifier, for: indexPath) as! InterestCollectionViewCell
        /* 
         – Thus the two are functionally identical.
         - would be better using "row" in the context of tables, and "item" in the context of collections.
         */
        cell.insterest = interests[indexPath.item]
        print(indexPath.item)
        return cell
    }
}





