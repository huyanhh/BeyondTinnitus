//
//  VolumeAdjust3ViewController.swift
//  BeyondTinnitus
//
//  Created by Huyanh Hoang on 2017. 4. 16..
//  Copyright © 2017년 teamMedApp. All rights reserved.
//

import UIKit

class VolumeAdjust3ViewController: UIViewController {
    
    @IBOutlet weak var slider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.value = 0.0
        
        FrequencyManager.shared.playAudioFile(tone: .sixteenth)
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        FrequencyManager.shared.sixteenthTone.volume = sender.value
    }

}
