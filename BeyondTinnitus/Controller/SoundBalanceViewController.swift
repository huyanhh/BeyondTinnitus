//
//  SoundBalanceViewController.swift
//  BeyondTinnitus
//
//  Created by Huyanh Hoang on 2016. 11. 19..
//  Copyright © 2016년 teamMedApp. All rights reserved.
//

import UIKit
import AVFoundation

class SoundBalanceViewController: UIViewController {

    @IBOutlet weak var slider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        slider.minimumValue = -1.0
        slider.maximumValue = 1.0
        slider.value = 0.0
        
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        FrequencyManager.shared.wholeTone.pan = sender.value
        FrequencyManager.shared.halfTone.pan = sender.value
        FrequencyManager.shared.sixteenthTone.pan = sender.value
    }

}
