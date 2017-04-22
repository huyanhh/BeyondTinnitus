//
//  SecondaryFrequencySettingViewController.swift
//  BeyondTinnitusv2
//
//  Created by Huyanh Hoang on 2017. 4. 7..
//  Copyright © 2017년 teamMedApp. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class ConfirmFrequencySettingViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func movePage() {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "adjustvolume1") as! VolumeAdjustViewController
        if let frequency = tf {
            secondViewController.tf = Int(frequency)
            self.navigationController?.pushViewController(secondViewController, animated: true)
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
        
        rowData.append(primaryFrequency / 2)
        rowData.append(primaryFrequency)
        rowData.append(primaryFrequency * 2)
        
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
        cell.textLabel?.text = String(rowData[indexPath.row])
        
        return cell
    }
    
    // Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let freq = rowData[indexPath.row]
        tf = freq
        label?.text = String(format: "You have selected %f Hz", freq)
        
  }
    
}
