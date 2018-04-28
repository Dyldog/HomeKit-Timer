//
//  TimerViewController.swift
//  HomeTimer
//
//  Created by ELLIOTT, Dylan on 27/4/18.
//  Copyright © 2018 Dylan Elliott. All rights reserved.
//

import UIKit

struct TimerModel {
    let duration: Int // in secondds
    let completionHandler: () -> Void
}

class TimerViewController: UIViewController {
    
    var timerModel: TimerModel! { // Should be set before viewWillAppear
        didSet {
            timeRemaining = timerModel.duration
        }
    }
    
    var timeRemaining: Int?
    
    var timer: Timer?
    
    @IBOutlet var timerLabel: UILabel!
    
    
    override func viewDidLoad() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tickTimer))
        timerLabel.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        updateTimerLabel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        startTimer()
    }
    
    func startTimer() {
        RunLoop.main.add(
            Timer(timeInterval: 1, repeats: true, block: { timer in self.tickTimer() }),
            forMode: .defaultRunLoopMode)
    }
    
    
    
    @objc func tickTimer() {
        guard let timeRemaining = timeRemaining,
                timeRemaining >= 0 else {
            timer?.invalidate()
            return
        }
        
        if timeRemaining > 0 {
            self.timeRemaining = timeRemaining - 1
        } else if timeRemaining == 0 {
            timer?.invalidate()
            timerCompleted()
        }
        
        updateTimerLabel()
    }
    
    func updateTimerLabel() {
        guard let timeRemaining = timeRemaining else { return }
        
        let seconds = timeRemaining % 60
        let minutesInSeconds = (timeRemaining - seconds) % (60 * 60)
        let hoursInSeconds = timeRemaining - minutesInSeconds
        
        let hours = Int(hoursInSeconds / (60 * 60))
        let minutes = Int(minutesInSeconds / 60)
        
        if hours > 0 {
            timerLabel.text = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        } else {
            timerLabel.text = String(format: "%02d:%02d", minutes, seconds)
        }
        
    }
    
    func timerCompleted() {
        timerModel.completionHandler()
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func pauseButtonTapped() {
    
    }
    
    @IBAction func resetButtonTapped() {
    
    }
    
    @IBAction func stopButtonTapped() {
    
    }
}
