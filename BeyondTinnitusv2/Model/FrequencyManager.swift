//
//  FrequencyManager.swift
//  BeyondTinnitusv2
//
//  Created by Huyanh Hoang on 2017. 4. 16..
//  Copyright © 2017년 teamMedApp. All rights reserved.
//

import Foundation
import AVFoundation

enum Tone: Int {
    case whole = 1
    case half = 2
    case sixteenth = 3
}

final class FrequencyManager {
    
    var wholeTone: AVAudioPlayer!
    var halfTone: AVAudioPlayer!
    var sixteenthTone: AVAudioPlayer!
    
    static var shared = FrequencyManager()
    
    private init() {
        
    }
    
    fileprivate func getAudioFileURL(frequency: String, tone: Tone) -> URL {
        let filename = "Tf-\(frequency)_Band\(tone.rawValue).mp4"
        guard let path = Bundle.main.path(forResource: filename, ofType: nil)
            else { fatalError("not valid path") }
        return URL(fileURLWithPath: path)
    }
    
    func setupAudioFiles(frequency: String) {
        let url = getAudioFileURL(frequency: frequency, tone: .whole)
        let url2 = getAudioFileURL(frequency: frequency, tone: .half)
        let url3 = getAudioFileURL(frequency: frequency, tone: .sixteenth)
        
        do {
            wholeTone = try AVAudioPlayer(contentsOf: url)
            wholeTone.numberOfLoops = -1
            halfTone = try AVAudioPlayer(contentsOf: url2)
            halfTone.numberOfLoops = -1
            sixteenthTone = try AVAudioPlayer(contentsOf: url3)
            sixteenthTone.numberOfLoops = -1
        } catch {
            print("couldnt load file")
        }
    }
    
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
    
    func pauseAudioFile(tone: Tone) {
        switch tone {
        case .whole:
            wholeTone.stop()
        case .half:
            halfTone.stop()
        case .sixteenth:
            sixteenthTone.stop()
        }
    }
    
    func playAll() {
        wholeTone.play()
        halfTone.play()
        sixteenthTone.play()
    }
}


