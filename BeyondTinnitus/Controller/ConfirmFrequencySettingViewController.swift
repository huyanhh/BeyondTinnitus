//
//  SecondaryFrequencySettingViewController.swift
//  BeyondTinnitus
//
//  Created by Huyanh Hoang on 2017. 4. 7..
//  Copyright © 2017년 teamMedApp. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class ConfirmFrequencySettingViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func movePage() {
        let volumeVC = self.storyboard?.instantiateViewController(withIdentifier: "adjustvolume1") as! VolumeAdjustViewController
        if let frequency = tf {
            volumeVC.tf = Int(frequency)
            self.navigationController?.pushViewController(volumeVC, animated: true)
        }
        if tone.isPlaying {
            engine.mainMixerNode.volume = 0.0
            tone.stop()
        }
    }
    
    var primaryFrequency: Double!
    var tf: Double?
    var rowData: [Double] = []
    var engine: AVAudioEngine!
    var tone: AVTonePlayerUnit!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        if primaryFrequency / 2 >= 2000 { rowData.append(primaryFrequency / 2) }
        rowData.append(primaryFrequency)
        if primaryFrequency * 2 <= 10000 { rowData.append(primaryFrequency * 2) }
    }
    
    
}

extension ConfirmFrequencySettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    // DataSource
    @nonobjc func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = FrequencyCell()
        cell.textLabel?.text = "\(String(rowData[indexPath.row])) Hz"
        
        return cell
    }
    
    // Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let freq = rowData[indexPath.row]
        tf = freq
        
        tone.frequency = freq
        
        tone.preparePlaying()
        tone.play()
        engine.mainMixerNode.volume = 1.0
  }
    
}
