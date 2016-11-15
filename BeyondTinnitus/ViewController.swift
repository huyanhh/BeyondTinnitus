//
//  ViewController.swift
//  BeyondTinnitus
//
//  Created by Vincent Gentile on 11/15/16.
//  Copyright © 2016 Vincent Gentile. All rights reserved.
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

    @IBAction func playSynthesizer(_ sender: UIButton) {
        FMSynthesizer.sharedSynth().play(100,modulatorFrequency: 20,modulatorAmplitude: 0.5)
    
    }

    @IBAction func playPureTone(_ sender: UIButton) {
        let playTone = ToneOutputUnit()
        playTone.setFrequency(freq: 8000)
        playTone.setToneVolume(vol: 1.0)
        playTone.setToneTime(t: 100)
        playTone.enableSpeaker()
        playTone.startToneForDuration(time: 20)
    }
    
}

