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
    
    var engine: AVAudioEngine!
    var tone: AVTonePlayerUnit!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slider.minimumValue = -5.0
        slider.maximumValue = 5.0
        slider.value = 0.0

    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        tone.volume = sender.value
    }
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller =  segue.destination as? SoundBalanceViewController
        controller?.tone = tone
        controller?.engine = engine
    }
    
}
