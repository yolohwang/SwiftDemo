//
//  ViewController.swift
//  SwiftDemo02
//
//  Created by 黄永乐 on 17/2/9.
//  Copyright © 2017年 Yolo. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITableViewDelegate{

    fileprivate let mainStopwatch: Stopwatch = Stopwatch()
    fileprivate let lapStopwatch: Stopwatch = Stopwatch()
    fileprivate var isPlay: Bool = false
    fileprivate var laps: [String] = []
    
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var lapTimerLabel: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var lapRestButton: UIButton!
    @IBOutlet weak var lapsTableView: UITableView!
    
    
    fileprivate func initCircleBtn(_ button: UIButton) {
        button.layer.cornerRadius = button.bounds.size.width/2
        button.layer.masksToBounds = true
        button.backgroundColor = UIColor.white
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCircleBtn(playPauseButton)
        initCircleBtn(lapRestButton)
        
        lapRestButton.isEnabled = false
        
        lapsTableView.delegate = self
        lapsTableView.dataSource = self
    }
    
    @IBAction func playPauseTimer(_ sender: AnyObject) {
        lapRestButton.isEnabled = true
        changeButton(lapRestButton, title: "lap", titleColor: UIColor.black)
        if !isPlay {
            mainStopwatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: self, selector: Selector.updateMainTimer, userInfo: nil, repeats: true)
            lapStopwatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: self, selector: Selector.updateLapTimer, userInfo: nil, repeats: true)
            isPlay = true
            changeButton(playPauseButton, title: "Stop", titleColor: .red)
        } else {
            mainStopwatch.timer.invalidate()
            lapStopwatch.timer.invalidate()
            isPlay = false
            changeButton(playPauseButton, title: "Start", titleColor: .red)
            changeButton(lapRestButton, title: "Reset", titleColor: .black)
        }
    }

    fileprivate func changeButton(_ button: UIButton, title: String, titleColor: UIColor) -> (){
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: UIControlState())
    }
    
    @IBAction func lapResetTimer(_ sender: AnyObject) {
        if !isPlay {
            resetMainTimer()
            resetLapTimer()
            changeButton(lapRestButton, title: "Lap", titleColor: .lightGray)
            lapRestButton.isEnabled = false
        } else {
            if let timerLabelText = timerLabel.text {
                laps.append(timerLabelText)
            }
            lapsTableView.reloadData()
            resetLapTimer()
            lapStopwatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: self, selector: Selector.updateLapTimer, userInfo: nil, repeats: true)
        }
        
    }
    
    fileprivate func resetMainTimer() {
        resetTimer(mainStopwatch, label: timerLabel)
        laps.removeAll()
        lapsTableView.reloadData()
    }
    
    fileprivate func resetLapTimer() {
        resetTimer(lapStopwatch, label: lapTimerLabel)
    }
    
    fileprivate func resetTimer(_ stopwatch: Stopwatch, label: UILabel) {
        stopwatch.timer.invalidate()
        stopwatch.counter = 0.0
        label.text = "00:00:00"
    
    }
    
    func updateMainTimer() {
        updateTimer(mainStopwatch, label: timerLabel)
    }
    
    func updateLapTimer() {
        updateTimer(lapStopwatch, label: lapTimerLabel)
    }
    
    fileprivate func updateTimer(_ stopwatch: Stopwatch, label: UILabel) {
        stopwatch.counter = stopwatch.counter + 0.035
        
        var minutes: String = "\((Int)(stopwatch.counter / 60))"
        if (Int)(stopwatch.counter / 60) < 10 {
            minutes = "0\((Int)(stopwatch.counter / 60))"
        }
        
        
        //float 取余
        var second: String = String (format: "%.2f", (stopwatch.counter.truncatingRemainder(dividingBy: 60)))
        if stopwatch.counter.truncatingRemainder(dividingBy: 60) < 10 {
            second = "0" + second
        }
        label.text = minutes + ":" + second
    }
}



extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return laps.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier :String = "lapCell"
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        if let labelnum = cell.viewWithTag(11) as? UILabel {
            labelnum.text = "lap \(laps.count - (indexPath as NSIndexPath).row)"
        }
        if let labeltimer = cell.viewWithTag(12) as? UILabel {
            labeltimer.text = laps[laps.count - indexPath.row - 1]
        }
        return cell
    }
}

fileprivate extension Selector {
    static let updateMainTimer = #selector(ViewController.updateMainTimer)
    static let updateLapTimer = #selector(ViewController.updateLapTimer)
}

