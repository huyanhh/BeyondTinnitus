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

    var engine: AVAudioEngine!
    
    @IBOutlet weak var slider: UISlider!
    
    var tone: AVTonePlayerUnit!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        slider.minimumValue = -1.0
        slider.maximumValue = 1.0
        slider.value = 0.0
        
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        engine.mainMixerNode.pan = sender.value
        print(engine)
        print(engine.mainMixerNode.pan)
        print(sender.value)
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let controller = segue.destination 
//        
//    }
 

}
