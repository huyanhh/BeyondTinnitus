//
//  VolumeAdjustViewController.swift
//  BeyondTinnitus
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
        slider.value = FrequencyManager.shared.wVolume
        
        FrequencyManager.shared.tf = String(tf)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        FrequencyManager.shared.stopAudioFile(tone: .half)
        FrequencyManager.shared.playAudioFile(tone: .whole)
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        FrequencyManager.shared.wVolume = sender.value
    }
    
}
