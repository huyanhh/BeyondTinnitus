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

    var engine: AVAudioEngine!
    var tone: AVTonePlayerUnit!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller =  segue.destination as? SoundBalanceViewController
        controller?.tone = tone
        controller?.engine = engine
    }
    
}
