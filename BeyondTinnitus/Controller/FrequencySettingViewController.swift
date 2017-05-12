//
//  FrequencySettingViewController.swift
//  BeyondTinnitus
//
//  Created by Huyanh Hoang on 2016. 11. 19..
//  Copyright © 2016년 teamMedApp. All rights reserved.
//

import UIKit
import AVFoundation

class FrequencySettingViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var label: UILabel!
    
    @IBAction func movePage() {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "confirm") as! ConfirmFrequencySettingViewController
        if let frequency = primaryFrequency {
            secondViewController.primaryFrequency = frequency
            secondViewController.engine = engine
            secondViewController.tone = tone
            self.navigationController?.pushViewController(secondViewController, animated: true)
        }
        if tone.isPlaying {
            engine.mainMixerNode.volume = 0.0
            tone.stop()
        }
    }
    
    var engine: AVAudioEngine!
    var tone: AVTonePlayerUnit!
    
    var rowData: [Double] = [2000, 4000, 6000, 8000, 10000]
    var primaryFrequency: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        tone = AVTonePlayerUnit()
        engine = AVAudioEngine()
        engine.attach(tone)
        
        let mixer = engine.mainMixerNode
        
        engine.connect(tone, to: mixer, format: AVAudioFormat(standardFormatWithSampleRate: tone.sampleRate, channels: 1))
        
        do {
            try engine.start()
        } catch let error as NSError {
            print(error)
        }
    }
}

extension FrequencySettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    // DataSource
    @nonobjc func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = FrequencyCell()
        cell.textLabel?.text = String(rowData[indexPath.row])
        
        return cell
    }
    
    // Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let freq = rowData[indexPath.row]
        tone.frequency = freq
        primaryFrequency = freq
        label?.text = String(format: "You have selected %f Hz", freq)
        
        tone.preparePlaying()
        tone.play()
        engine.mainMixerNode.volume = 1.0
    }
    
}
