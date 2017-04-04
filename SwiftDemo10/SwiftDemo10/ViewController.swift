//
//  ViewController.swift
//  SwiftDemo10
//
//  Created by YoloHwang on 17/3/20.
//  Copyright © 2017年 Yolo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    @IBAction func unwindBackToMainVC(_ sender: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }

}

