//
//  SoundBalanceViewController.swift
//  BeyondTinnitus
//
//  Created by Huyanh Hoang on 2016. 11. 19..
//  Copyright © 2016년 teamMedApp. All rights reserved.
//

import UIKit
import AVFoundation
import os.log

class SoundBalanceViewController: UIViewController {

    @IBOutlet weak var slider: UISlider!
    @IBAction func presentDashboard() {
        if FrequencyManager.shared.wholeTone.pan == 0 {
            Utility.alert(message: "You haven't set your balance yet!", vc: self)
            return
        }
        FrequencyManager.shared.stopAll()
        FrequencyManager.shared.saveToneSettings()
        
        UserDefaults.standard.set(true, forKey: "onboard")
        UserDefaults.standard.synchronize()
        
        guard let dashboardVC = self.storyboard?.instantiateViewController(withIdentifier: "tab_bar") as? UITabBarController
            else { fatalError() }
        present(dashboardVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        slider.minimumValue = -1.0
        slider.maximumValue = 1.0
        slider.value = 0.0
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        FrequencyManager.shared.stopAudioFile(tone: .sixteenth)
        FrequencyManager.shared.playAll()
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        FrequencyManager.shared.wPan = sender.value
        FrequencyManager.shared.hPan = sender.value
        FrequencyManager.shared.sPan = sender.value
    }
}
