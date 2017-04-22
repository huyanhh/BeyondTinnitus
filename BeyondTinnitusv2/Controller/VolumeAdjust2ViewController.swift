//
//  VolumeAdjust2ViewController.swift
//  BeyondTinnitusv2
//
//  Created by Huyanh Hoang on 2017. 4. 16..
//  Copyright © 2017년 teamMedApp. All rights reserved.
//

import UIKit

class VolumeAdjust2ViewController: UIViewController {
    
    @IBOutlet weak var slider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.value = 0.0
        
        FrequencyManager.shared.playAudioFile(tone: .half)
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        FrequencyManager.shared.halfTone.volume = sender.value
    }

}
