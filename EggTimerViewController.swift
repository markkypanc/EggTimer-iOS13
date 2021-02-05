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
    
    // All interface we are using in View
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var eggProgress: UIProgressView!
    
    // Dictionaries
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7]
    
    var timer = Timer()
    var totalProgress: Int = 0
    var secondPassed: Int = 0
    
    @IBAction func allButtons(_ sender: UIButton) {
        
        timer.invalidate()
        let hardness = sender.currentTitle! // Soft, Medium or hard
        totalProgress = eggTimes[hardness]! // 3, 4, 7
        
        eggProgress.progress = 0.0
        secondPassed = 0 
        textLabel.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if secondPassed < totalProgress {
            secondPassed += 1
            eggProgress.progress = Float(secondPassed) / Float(totalProgress)
            print("The progress has passed \(eggProgress.progress * 100) %")
        } else {
            timer.invalidate()
            textLabel.text = "Done!"
            playsound(file: "alarm_sound", extend: "mp3")
            print("The progress has passed \(eggProgress.progress * 100) %")
        }
    }
    
    var player: AVAudioPlayer?
    
    func playsound(file: String, extend: String) {
        
        guard let url = Bundle.main.url(forResource: file, withExtension: extend) else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let player = player else { return }

                    player.play()

                } catch let error {
                    print(error.localizedDescription)
                }
        }
}
