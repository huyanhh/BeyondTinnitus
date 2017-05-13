//
//  VolumeAdjust2ViewController.swift
//  BeyondTinnitus
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
        slider.value = FrequencyManager.shared.hVolume

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        FrequencyManager.shared.stopAudioFile(tone: .whole)
        FrequencyManager.shared.stopAudioFile(tone: .sixteenth)
        FrequencyManager.shared.playAudioFile(tone: .half)
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        FrequencyManager.shared.hVolume = sender.value
    }

}
