//
//  FrequencySettingViewController.swift
//  BeyondTinnitusv2
//
//  Created by Huyanh Hoang on 2016. 11. 19..
//  Copyright © 2016년 teamMedApp. All rights reserved.
//

import UIKit
import AVFoundation

class FrequencySettingViewController: UIViewController {

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var label: UILabel!

    var engine: AVAudioEngine! = FrequencyManager.shared.engine
    var tone: AVTonePlayerUnit! = FrequencyManager.shared.middle.centerTone
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slider.minimumValue = -5.0
        slider.maximumValue = 5.0
        slider.value = 0.0
    }
    
    @IBAction func sliderChanged(sender: UISlider) {
        let freq = 440.0 * pow(2.0, Double(sender.value))
        FrequencyManager.shared.centerFrequency = freq
        label.text = String(format: "%.1f", freq)
    }
    
    @IBAction func togglePlay(sender: UIButton) {
        if tone.isPlaying {
            engine.mainMixerNode.volume = 0.0
            FrequencyManager.shared.stop()
            sender.setTitle("Start", for: .normal)
        } else {
            FrequencyManager.shared.play()
            engine.mainMixerNode.volume = 1.0
            sender.setTitle("Stop", for: .normal)
            print("center tone: ", tone.frequency)
//            FrequencyManager.shared.tones.map { print($0?.frequency) }
            print("======")
        }
    }

    
    // MARK: - Navigation

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let controller = segue.destination as? VolumeAdjustViewController
//        controller?.tone = tone
//        controller?.engine = engine
//    }
}
