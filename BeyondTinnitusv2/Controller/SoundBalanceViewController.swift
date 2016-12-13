//
//  SoundBalanceViewController.swift
//  BeyondTinnitusv2
//
//  Created by Huyanh Hoang on 2016. 11. 19..
//  Copyright © 2016년 teamMedApp. All rights reserved.
//

import UIKit
import AVFoundation

class SoundBalanceViewController: UIViewController {

    @IBOutlet weak var slider: UISlider!
    
    var engine: AVAudioEngine! = FrequencyManager.shared.engine
    var tone: AVTonePlayerUnit! = FrequencyManager.shared.centerTone
    
    override func viewDidLoad() {
        super.viewDidLoad()

        slider.minimumValue = -1.0
        slider.maximumValue = 1.0
        slider.value = 0.0
        
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        tone.pan = sender.value
    }
    
    // MARK: - Navigation

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let controller = segue.destination as? DashboardViewController
//        controller?.tone = tone
//        controller?.engine = engine
//    }
 
}
