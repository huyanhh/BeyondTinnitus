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

    var engine: AVAudioEngine!
    var tone: AVTonePlayerUnit!
    var tone2: AVTonePlayerUnit!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tone = AVTonePlayerUnit()
        label.text = String(format: "%.1f", tone.frequency)
        slider.minimumValue = -5.0
        slider.maximumValue = 5.0
        slider.value = 0.0
        let format = AVAudioFormat(standardFormatWithSampleRate: tone.sampleRate, channels: 1)
        print(format.sampleRate)
        engine = AVAudioEngine()
        engine.attach(tone)
        let mixer = engine.mainMixerNode
        engine.connect(tone, to: mixer, format: format)
        do {
            try engine.start()
        } catch let error as NSError {
            print(error)
        }
    }
    
    @IBAction func sliderChanged(sender: UISlider) {
        let freq = 440.0 * pow(2.0, Double(sender.value))
        tone.frequency = freq
        label.text = String(format: "%.1f", freq)
    }
    
    @IBAction func togglePlay(sender: UIButton) {
        if tone.isPlaying {
            engine.mainMixerNode.volume = 0.0
            tone.stop()
            sender.setTitle("Start", for: .normal)
        } else {
            tone.preparePlaying()
            tone.play()
            engine.mainMixerNode.volume = 1.0
            sender.setTitle("Stop", for: .normal)
        }
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as? VolumeAdjustViewController
        controller?.tone = tone
        controller?.engine = engine
    }
 

}
