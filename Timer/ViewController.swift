//
//  ViewController.swift
//  Timer
//
//  Created by Mac on 28/10/22.
//

import UIKit

class ViewController: UIViewController {
    
    var timer:Timer = Timer()
    var count=Int()
    var timeCounting=false
    
    @IBOutlet weak var TimerLabel: UILabel!
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func resetTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Reset Timer ?", message: "Are You Sure ?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: { ( _ ) in }))
    
        alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { ( _ ) in
            self.count = 0
            self.timer.invalidate()
            self.TimerLabel.text = self.makeTimeString(hours: 0, minutes: 0, seconds: 0)
            self.startStopButton.setTitle("START", for: .normal)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func startStopTapped(_ sender: Any) {
        if(timeCounting){
            timeCounting=false
            timer.invalidate()
            startStopButton.setTitle("START", for: .normal)
        }else {
            timeCounting=true
            startStopButton.setTitle("STOP", for: .normal)
            timer=Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        }
    }
    
    @objc func timerCounter()->Void{
        count = count + 1
        let time = secondsToHoursMinutesSeconds(seconds: count)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        TimerLabel.text = timeString
    }
    
    func secondsToHoursMinutesSeconds(seconds:Int) -> (Int, Int, Int){
        return ((seconds/3600), ((seconds % 3600)/60), ((seconds % 3600)%60))
    }
    
    func makeTimeString(hours :Int, minutes:Int, seconds: Int) -> String
    {
        var timeString=String()
        timeString = timeString + String(format: "%02d", hours)
        timeString = timeString + " : "
        timeString = timeString + String(format: "%02d", minutes)
        timeString = timeString + " : "
        timeString = timeString + String(format: "%02d", seconds)
      return timeString
    }
}

