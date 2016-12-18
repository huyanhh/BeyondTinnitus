//
//  FrequencyManager.swift
//  BeyondTinnitusv2
//
//  Created by Huyanh Hoang on 2016. 12. 13..
//  Copyright © 2016년 teamMedApp. All rights reserved.
//

import Foundation
import AVFoundation

/// Singleton class for managing the frequency generator of the application
final class FrequencyManager {
    
    private let LEFT = 0.13
    private let MIDDLE = 0.26
    private let RIGHT = 0.016
    
    open var engine: AVAudioEngine!
    
    /// Shared singleton instance for calling frequency methods
    open static var shared = FrequencyManager()
    
    /// Array of tones, each with a range of pure tones
    private(set) var tones: [Tone] = []
    
    /// Center tone "range"
    private(set) var middle: Tone!
    
    /// Center frequency of the middle tone range
    open var centerFrequency: Double {
        get {
            return middle.centerTone.frequency
        }
        set {
            middle.adjustCenterFrequency(newValue: newValue)
            for var tone in tones {
                tone.adjustCenterFrequency(newValue: newValue)
            }
        }
    }
    
    private init() {
        setupEngine()
    }
    
    /// Plays all of the tones at once
    public func play() {
        for tone in tones {
            tone.play()
        }
    }
    
    public func stop() {
        for tone in tones {
            tone.stop()
        }
    }
    
    private func setupEngine() {
        engine = AVAudioEngine()
//        var left = Tone(multiplier: LEFT)
//        left.adjustCenterFrequency(newValue: (1/2) * left.centerTone.frequency)
        let middle = Tone(multiplier: MIDDLE, engine: engine)
        self.middle = middle
//        var right = Tone(multiplier: RIGHT)
//        right.adjustCenterFrequency(newValue: (1/16) * right.centerTone.frequency)
//        tones.append(contentsOf: [left, middle, right])
        tones.append(middle)
        
        do {
            try engine.start()
        } catch let error as NSError {
            print(error)
        }
    }
    
}
