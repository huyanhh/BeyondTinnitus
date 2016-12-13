//
//  DashboardViewController.swift
//  BeyondTinnitusv2
//
//  Created by Huyanh Hoang on 2016. 11. 19..
//  Copyright © 2016년 teamMedApp. All rights reserved.
//

import UIKit
import AVFoundation

class DashboardViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var engine: AVAudioEngine! = FrequencyManager.shared.engine
    var tone: AVTonePlayerUnit! = FrequencyManager.shared.centerTone
    
    fileprivate let sectionData = [" "]
    fileprivate let rowData = [["apple_music", "Play with Music"],
                           ["spotify", "Play with Spotify"],
                           ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func toggleplay(_ sender: UIButton) {
        if tone.isPlaying {
            engine.mainMixerNode.volume = 0.0
            tone.stop()
            sender.setImage(UIImage(named: "play"), for: .normal)
            
        } else {
            tone.preparePlaying()
            tone.play()
            engine.mainMixerNode.volume = 1.0
            sender.setImage(UIImage(named: "pause"), for: .normal)
        }
    }

}

extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
    
    // DataSource
    @nonobjc func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowData.count
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return sectionData[section]
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()

        cell.textLabel?.text = rowData[indexPath.row][1]
        cell.imageView?.image = UIImage(named: rowData[indexPath.row][0])
        
        return cell
    }

    // Delegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            guard let musicAppURL = URL(string: "music://") else { fatalError("probably playing from simulator") }
            if UIApplication.shared.canOpenURL(musicAppURL) {
                UIApplication.shared.open(musicAppURL, options: [:], completionHandler: nil)
            }
        default:
            print("hi")
            break
        }
    }
    
}
