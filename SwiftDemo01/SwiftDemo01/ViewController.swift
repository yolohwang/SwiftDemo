//
//  ViewController.swift
//  SwiftDemo01
//
//  Created by 黄永乐 on 17/2/8.
//  Copyright © 2017年 Yolo. All rights reserved.
//

import UIKit
import Social

class ViewController: UIViewController , UITextFieldDelegate {

    @IBOutlet weak var salarySlider: UISlider!
    @IBOutlet weak var salaryLabel: UILabel!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var workTF: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var genderSeg: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.nameTF.delegate = self
        self.workTF.delegate = self
    }
    
    
    @IBAction func salaryHandler(_ sender: Any) {
        let slider = sender as! UISlider
        let i = Int(slider.value)
        salaryLabel.text = "$\(i)k"
        
    }
    @IBAction func tweethandler(_ sender: UIButton) {
        if nameTF.text == "" || workTF.text == "" {
            showAlert("info miss", message: "plaease fill out the form", buttonTitle: "Ok")
        return
        }
        let name: String! = nameTF.text
        let work: String! = workTF.text
        let salary: String! = salaryLabel.text
        
        let gregorian = Calendar(identifier: Calendar.Identifier.gregorian)
        let now = Date()
        let components = (gregorian as NSCalendar?)?.components(NSCalendar.Unit.year, from: datePicker.date, to: now, options: [])
        let age: Int! = components?.year
        var interesetIn: String! = "women"
        if genderSeg.selectedSegmentIndex == 0 {
            interesetIn = "men"
        }
        
        let tweet = "Hi, I am \(name). As a \(age)-year-old \(work) earning \(salary)/year ,I am interested in \(interesetIn)."
        tweetSLCVC(tweet)
    }
    
    func tweetSLCVC(_ tweet: String) {
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeSinaWeibo) {
            let twitterViewController: SLComposeViewController = SLComposeViewController (forServiceType: SLServiceTypeSinaWeibo)
            twitterViewController.setInitialText(tweet)
            self.present(twitterViewController, animated: true, completion: {
                
            })
        }
        else
        {
            showAlert("sina Unavaolable", message: "please configure your sina account", buttonTitle: "Ok")
        }
    }
    
    
    func showAlert(_ title: String, message: String, buttonTitle: String) {
        let alert = UIAlertController (title: title, message: message, preferredStyle:UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction (title: buttonTitle, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }

    
}

