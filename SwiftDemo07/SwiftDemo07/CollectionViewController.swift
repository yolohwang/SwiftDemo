//
//  CollectionViewController.swift
//  SwiftDemo07
//
//  Created by YoloHwang on 17/3/9.
//  Copyright © 2017年 Yolo. All rights reserved.
//

import UIKit


class CollectionViewController: UICollectionViewController {
    fileprivate let reuseIdentifier = "PhotoCell"
    fileprivate let thumbnailSize:CGFloat = 70.0
    fileprivate let sectionInsets = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
    fileprivate let photos:[String] = ["photo1","photo2","photo3","photo4","photo5"]

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UICollectionViewCell,
            let indexPath = collectionView?.indexPath(for: cell),
            let managerPageViewController = segue.destination as? ManagerPageViewController {
            managerPageViewController.photos = photos
            managerPageViewController.currentIndicator = indexPath.row
        }
    }
}

extension CollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCell
     
        let fullSizeImage = UIImage(named:photos[indexPath.row])
        cell.photoImageView.image = fullSizeImage?.thumbnailOfSize(thumbnailSize)
        return cell
    }

}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize (width: thumbnailSize, height: thumbnailSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
}

extension UIImage {
    //根据size自定义image大小
    func thumbnailOfSize(_ size: CGFloat) -> UIImage {
        let rect = CGRect (x: 0, y: 0, width: size, height: size)
        UIGraphicsBeginImageContext(CGSize (width: size, height: size))
        draw(in: rect)
        let thumbnail = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return thumbnail!
    }
}














