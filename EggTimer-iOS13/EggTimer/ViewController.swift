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
    //let softTime = 5;
    //let mediumTime = 7;
    //let hardTime = 12;
    //*******************************************
    //AUDIO SOUND
    var player: AVAudioPlayer?
    //***************************************
    var result = 0;
    var count = 60;
    var totalTime:Float = 0;
    var secondsPassed: Float = 0;
    var percentageProgress:Float = 0;
    var eggTimes = ["Soft": 5, "Medium" :7 ,"Hard" :12]
  
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var label: UILabel!
    @IBAction func hardnessSelected(_ sender: UIButton) {
        let hardness = sender.currentTitle!;
         result = eggTimes[hardness]!;
        //print(result);
        if result == 5 {
             eggTimes[hardness] = 300
        }
        else if result == 7 {
            eggTimes[hardness] = 420
        }
        else{
            eggTimes[hardness] = 720
        }
        label.text = sender.currentTitle;
        //***************************************Audio***************
        
        func playSound() {
            guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }

            do {
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                try AVAudioSession.sharedInstance().setActive(true)

                /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
                player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

                /* iOS 10 and earlier require the following line:
                player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

                guard let player = player else { return }

                player.play()

            } catch let error {
                print(error.localizedDescription)
            }
        }
        if label.text != nil {
            playSound();
        }
        
        //*************************************************
             totalTime = Float(eggTimes[hardness]!);
        print("total egg time selected to boil is:")
        print(totalTime);
        
        //********************* Count down Timer*******************
    
       Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true)
        { (Timer) in
        if self.eggTimes[hardness]! > 0 {
            
            print("\(self.eggTimes[hardness]!)")
            self.eggTimes[hardness] = self.eggTimes[hardness]! - 1;
            self.secondsPassed = self.secondsPassed + 1;
            print("seconds passed is:")
            print(self.secondsPassed)
            }
            else{
                Timer.invalidate();
                //self.label.text = "DONE";
            }
       self.label.text = "Count down started : \(self.eggTimes[hardness]!)";
        self.percentageProgress = Float(self.secondsPassed)/Float(self.totalTime);
        print("Value is:")
        print(self.percentageProgress)
        print("percentage progress is:")
        if self.percentageProgress < 1 {
            self.progressBar.progress =  self.percentageProgress;
            
        }
        else{
            self.progressBar.progress =  1;
            
        }
        print(self.progressBar.progress)
        }
        //let hardness = sender.currentTitle
       /* if(hardness == "soft"){
            print(softTime)
        }
        else if(hardness == "medium"){
            print(mediumTime)
        }
        else{
            print(hardTime)
            
        }*/
        
       /* switch hardness {
        case "soft":
            print(softTime)
        case "medium":
            print(mediumTime)
        case "hard":
            print(hardTime)
        default:
            print("Error")
        }*/
    }

}
