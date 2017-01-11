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
    
    /// Multiplier for low and high range of frequencies
    /// Left uses 1/2Tf + .13*Tf, Right uses 1/16Tf + .016*Tf
    enum Multiplier {
        static let LEFT_R: Double = 1/2
        static let LEFT_C = 0.13
        static let MIDDLE_R = 0.26
        static let MIDDLE_C: Double = 1.0
        static let RIGHT_R = 0.016
        static let RIGHT_C: Double = 1/16
    }
    
    open var engine: AVAudioEngine!
    
    /// Shared singleton instance for calling frequency methods
    open static var shared = FrequencyManager()
    
    /// Array of center tones, each with a range of pure tones
    private(set) var tones: [Tone] = []
    
    /// Center tone "range"
    private(set) var middle: Tone!
    
    /// Center frequency within the middle tone range
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
    
    /// Sets up all the Tf's based on the formula. The original Tf (currently `middle`) must be set first before
    /// the other Tf's are set
    private func setupEngine() {
        engine = AVAudioEngine()
        print("set up engine")
        let middle = Tone(multiplierCenter: Multiplier.MIDDLE_C, multiplierRange: Multiplier.MIDDLE_R, engine: engine)
        self.middle = middle
        print(middle.centerTone.frequency)
        let left = Tone(multiplierCenter: Multiplier.LEFT_C, multiplierRange: Multiplier.LEFT_R, engine: engine)
        print(left.centerTone.frequency)
        let right = Tone(multiplierCenter: Multiplier.RIGHT_C, multiplierRange: Multiplier.LEFT_R, engine: engine)
        print(right.centerTone.frequency)
        tones.append(contentsOf: [left, middle, right])
        print("before start")
        do {
            try engine.start()
        } catch let error as NSError {
            print(error)
        }
    }
    
}
