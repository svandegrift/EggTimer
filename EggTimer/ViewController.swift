//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    let eggTime = ["Soft":300, "Medium":420, "Hard" : 720]
    var totalTime = 0
    var secondsPassed = 0
    var timer = Timer()
    var delay = Timer()
    var player: AVAudioPlayer!
    
    @objc func UpdateCounter(){
        if secondsPassed < totalTime {
            secondsPassed += 1
            print(Float(secondsPassed)/Float(totalTime))
            progressBar.progress = Float(secondsPassed)/Float(totalTime)
        }else{
            timer.invalidate()
            titleLabel.text = "Done!"
            playSound()
            
        }
    }
    
    @objc func ResetLabel(){
        titleLabel.text = "How do you like your eggs?"
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
                
    }
    
    @IBAction func HardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        let hardness = sender.currentTitle!
        totalTime = eggTime[hardness]!
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = "\(hardness) boiling..."
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(UpdateCounter), userInfo: nil, repeats: true)
        
    }
}
