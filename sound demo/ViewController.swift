//
//  ViewController.swift
//  sound demo
//
//  Created by MacStudent on 2020-01-07.
//  Copyright © 2020 MacStudent. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    
    
    var player = AVAudioPlayer()//instance of this
    
    let path = Bundle.main.path(forResource: "bach", ofType: "mp3")//provide a path for audio file
    
    var timer = Timer()
    @IBOutlet weak var valueslider: UISlider!
    @IBOutlet weak var scrvalues: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()
//        do{
//        player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path!))
//
//            scrvalues.maximumValue = Float(player.duration)
//        }
//        catch{
//            print(error)
//        }
        // Do any additional setup after loading the view.
    }

    @IBAction func pausebutton(_ sender: UIBarButtonItem) {
        
        player.pause()
//        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updatescrubber), userInfo: nil, repeats: true)
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if event?.subtype == UIEvent.EventSubtype.motionShake
        {
            let soundArray = ["boing", "explosion", "hit", "knife", "shoot", "swish", "wah", "warble"  ]
            
            let randomNumber = Int(arc4random_uniform(UInt32(soundArray.count)))
            
            let filelocation = Bundle.main.path(forResource: soundArray[randomNumber], ofType: "mp3")
            
            do{
                 try  player =  AVAudioPlayer(contentsOf: URL(fileURLWithPath: filelocation!))
                player.play()
                       
                       //scrvalues.maximumValue = Float(player.duration)
                   }
                   catch{
                       print(error)
                   }
        }
    }
    
    
    
    
    @IBAction func playbutton(_ sender: UIBarButtonItem) {
        player.play()
         timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updatescrubber), userInfo: nil, repeats: true)
    }
    
    
    @IBAction func stopbutton(_ sender: UIButton) {
        player.stop()
        player.currentTime = 0
        timer.invalidate()
    }
    
    @IBAction func volumechanged(_ sender: UISlider){
        player.volume = valueslider.value
        
    }
    @objc func updatescrubber(){
        scrvalues.value = Float(player.currentTime)
        
    }
    
    @IBAction func scrubbermoved(_ sender: UISlider) {
        player.currentTime = TimeInterval(scrvalues.value)
        player.play()
    }
    
    
    
}

