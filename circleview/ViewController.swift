//
//  ViewController.swift
//  circleview
//
//  Created by Yuji Ogihara on 2019/04/29.
//  Copyright © 2019年 Yuji Ogihara. All rights reserved.
//

import UIKit
import CircleProgressView

class ViewController: UIViewController {

    @IBOutlet var progressView: CircleProgressView!
    @IBOutlet var slider: UISlider!
    @IBOutlet var value: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let v = slider.value
        value.text = String(Int(v * 100.0))
        progressView.progress = Double(v)
    }
    
    @IBAction func onSliderChanged(_ sender: UISlider) {
        value.text = String(Int(sender.value * 100.0))
        progressView.progress = Double(sender.value)
    }

    
    var timer: Timer!
    let countdownSeconds = 3
    var remainedTickCount = 0
    var timerIntervalSecounds = 0.1
    var totalTickCount = 0
    
    @IBAction func onCountdownStart(_ sender: Any) {
        progressView.progress = 0.0
        value.text = String(Int(countdownSeconds))
        totalTickCount = Int(Double(countdownSeconds) / Double(timerIntervalSecounds))
        remainedTickCount = totalTickCount
        startTimer()
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(
            timeInterval: timerIntervalSecounds,
            target: self,
            selector: #selector(self.timerCounter),
            userInfo: nil,
            repeats: true)
    }
    
    @objc func timerCounter() {

        // Update progress
        remainedTickCount = remainedTickCount - 1 
        progressView.progress = Double(totalTickCount - remainedTickCount) / Double(totalTickCount)

        // Update remained seconds
        if ((remainedTickCount % Int(1.0 / timerIntervalSecounds)) == 0) {
            value.text = String(remainedTickCount / Int(1.0 / timerIntervalSecounds))
        }

        // Finished ?
        if (remainedTickCount <= 0) {
            stopTimer()
        }
    }
 
    func stopTimer() {
        if timer != nil{
            timer.invalidate()
        }
    }
}

