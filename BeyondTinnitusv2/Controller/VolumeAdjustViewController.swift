//
//  VolumeAdjustViewController.swift
//  BeyondTinnitusv2
//
//  Created by Huyanh Hoang on 2016. 11. 19..
//  Copyright © 2016년 teamMedApp. All rights reserved.
//

import UIKit
import AVFoundation

class VolumeAdjustViewController: UIViewController {

    @IBOutlet weak var slider: UISlider!
    
    var tf: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.value = 0.0
        
        FrequencyManager.shared.setupAudioFiles(frequency: String(tf))
        FrequencyManager.shared.playAudioFile(tone: .whole)
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        FrequencyManager.shared.wholeTone.volume = sender.value
    }
    
}
