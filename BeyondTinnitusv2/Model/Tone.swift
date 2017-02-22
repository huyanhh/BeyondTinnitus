//
//  Tone.swift
//  BeyondTinnitusv2
//
//  Created by Huyanh Hoang on 2016. 12. 17..
//  Copyright © 2016년 teamMedApp. All rights reserved.
//

import Foundation
import AVFoundation

/// Tone at a specific frequency, has a range that spans a certain percentage i.e. ±25%
struct Tone {
    
    var engine: AVAudioEngine
        
    private let DEFAULT_FREQUENCY = 440.0
    
    /// Amount of tones to play
    private let TONE_RANGE = 200
    /// Multiplier for calculating the range of frequencies to play
    private let multiplierCenter: Double
    private let multiplierRange: Double
    
    /// Low of the range, based on the center tone's frequency
    private var low: Double {
        if (centerTone) != nil {
            return centerTone.frequency - centerTone.frequency * multiplierRange
        } else { return DEFAULT_FREQUENCY - DEFAULT_FREQUENCY * multiplierRange }
    }
    private var high: Double {
        if (centerTone) != nil {
            return centerTone.frequency + centerTone.frequency * multiplierRange
        } else { return DEFAULT_FREQUENCY + DEFAULT_FREQUENCY * multiplierRange }
    }
    
    private(set) var outerTones: [AVTonePlayerUnit?] = []
    private(set) var centerTone: AVTonePlayerUnit!
    
    init(multiplierCenter: Double, multiplierRange: Double, engine: AVAudioEngine) {
        self.multiplierCenter = multiplierCenter
        self.multiplierRange = multiplierRange
        self.engine = engine
        generateTones()
        centerTone = outerTones[TONE_RANGE / 2]
        adjustCenterFrequency(newValue: centerTone.frequency)
    }
    
    /// Set the frequency of all the tones uniformly based on the difference of the slider
    public mutating func adjustCenterFrequency(newValue: Double) {
        centerTone.frequency = newValue * multiplierCenter
        for (index, tone) in outerTones.enumerated() {
            tone?.frequency = calculateFrequency(at: index)
        }
    }
    
    public func play() {
        for tone in outerTones {
            tone?.preparePlaying()
            tone?.play()
        }
    }
    
    public func stop() {
        for tone in outerTones {
            tone?.stop()
        }
    }
    
    /// Generates all the tones in the range ±25% of the center frequency
    ///
    /// - Parameter amount: range of steps to loop through
    private mutating func generateTones() {
        for index in 0...TONE_RANGE {
            let tone = AVTonePlayerUnit()
            tone.frequency = calculateFrequency(at: index)
            outerTones.append(tone)
            connect(tone: tone)
        }
    }
    
    /// Calculates a frequency at a specific index
    ///
    /// - Parameter index: Index of tone array
    /// - Returns: Frequency at index
    private func calculateFrequency(at index: Int) -> Double {
        return low + Double(index) * ((high - low) / Double(TONE_RANGE))
    }
    
    private func connect(tone: AVTonePlayerUnit) {
        let format = AVAudioFormat(standardFormatWithSampleRate: tone.sampleRate, channels: 1)
        let mixer = engine.mainMixerNode
        engine.attach(tone)
        engine.connect(tone, to: mixer, format: format)
    }
    
}
