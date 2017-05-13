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
        slider.value = FrequencyManager.shared.sVolume

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        FrequencyManager.shared.stopAudioFile(tone: .half)
        FrequencyManager.shared.playAudioFile(tone: .sixteenth)
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        FrequencyManager.shared.sVolume = sender.value
    }

}
