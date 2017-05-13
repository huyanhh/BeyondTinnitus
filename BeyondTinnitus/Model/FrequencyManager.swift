//
//  FrequencyManager.swift
//  BeyondTinnitus
//
//  Created by Huyanh Hoang on 2017. 4. 16..
//  Copyright © 2017년 teamMedApp. All rights reserved.
//

import Foundation
import AVFoundation
import os.log

enum Tone: Int {
    case whole = 1
    case half = 2
    case sixteenth = 3
}

final class FrequencyManager: NSObject, NSCoding {
    
    fileprivate(set) var wholeTone: AVAudioPlayer!
    fileprivate(set) var halfTone: AVAudioPlayer!
    fileprivate(set) var sixteenthTone: AVAudioPlayer!
    
    var wVolume: Float = 0 { didSet { wholeTone.volume = wVolume } }
    var hVolume: Float = 0 { didSet { halfTone.volume = hVolume } }
    var sVolume: Float = 0 { didSet { sixteenthTone.volume = sVolume } }
    
    var wPan: Float = 0 { didSet { wholeTone.pan = wPan } }
    var hPan: Float = 0 { didSet { halfTone.pan = hPan } }
    var sPan: Float = 0 { didSet { sixteenthTone.pan = sPan } }
    
    var tf: String = "" {
        didSet {
            setupAudioFiles()
        }
    }
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("tones")
    
    static let shared = FrequencyManager()
    
    private override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.wVolume = aDecoder.decodeFloat(forKey: "wv")
        self.hVolume = aDecoder.decodeFloat(forKey: "hv")
        self.sVolume = aDecoder.decodeFloat(forKey: "sv")
        self.wPan = aDecoder.decodeFloat(forKey: "wp")
        self.hPan = aDecoder.decodeFloat(forKey: "hp")
        self.sPan = aDecoder.decodeFloat(forKey: "sp")
        self.tf = aDecoder.decodeObject(forKey: "tf") as! String
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(tf, forKey: "tf")
        aCoder.encode(wVolume, forKey: "wv")
        aCoder.encode(hVolume, forKey: "hv")
        aCoder.encode(sVolume, forKey: "sv")
        aCoder.encode(wPan, forKey: "wp")
        aCoder.encode(hPan, forKey: "hp")
        aCoder.encode(sPan, forKey: "sp")
    }
    
    fileprivate func getAudioFileURL(frequency: String, tone: Tone) -> URL {
        let filename = "Tf-\(frequency)_Band\(tone.rawValue).mp4"
        guard let path = Bundle.main.path(forResource: filename, ofType: nil)
            else { fatalError("not valid path") }
        return URL(fileURLWithPath: path)
    }
    
    func setupAudioFiles() {
        let url = getAudioFileURL(frequency: tf, tone: .whole)
        let url2 = getAudioFileURL(frequency: tf, tone: .half)
        let url3 = getAudioFileURL(frequency: tf, tone: .sixteenth)
        
        do {
            // Set volume to 0 when initialized, load volume if persisted
            wholeTone = try AVAudioPlayer(contentsOf: url)
            wholeTone.volume = wVolume
            wholeTone.numberOfLoops = -1
            halfTone = try AVAudioPlayer(contentsOf: url2)
            halfTone.volume = hVolume
            halfTone.numberOfLoops = -1
            sixteenthTone = try AVAudioPlayer(contentsOf: url3)
            sixteenthTone.volume = sVolume
            sixteenthTone.numberOfLoops = -1
        } catch {
            print("couldnt load file")
        }
    }
    
    
    /// Only to be used in the onboarding
    func playAudioFile(tone: Tone) {
        switch tone {
        case .whole:
            wholeTone.play()
        case .half:
            halfTone.play()
        case .sixteenth:
            sixteenthTone.play()
        }
    }
    
    /// Only to be used in the onboarding
    func stopAudioFile(tone: Tone) {
        switch tone {
        case .whole:
            if wholeTone.isPlaying {
                wholeTone.stop()
            }
        case .half:
            if halfTone.isPlaying {
                halfTone.stop()
            }
        case .sixteenth:
            if sixteenthTone.isPlaying {
                sixteenthTone.stop()
            }
        }
    }

    
    func playAll() {
        wholeTone.play()
        halfTone.play()
        sixteenthTone.play()
    }
    
    func stopAll() {
        wholeTone.stop()
        halfTone.stop()
        sixteenthTone.stop()
    }
}


