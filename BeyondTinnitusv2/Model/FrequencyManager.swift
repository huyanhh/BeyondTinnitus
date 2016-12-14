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
    
    /// Amount of tones to play
    private let TONE_RANGE = 50
    /// Multiplier for calculating the range of frequencies to play
    private let MULTIPLIER = 0.25
    private let DEFAULT_FREQUENCY = 440.0
    
    /// Low of the range, based on the center tone's frequency
    private var low: Double {
        if (centerTone) != nil {
            return centerTone.frequency - centerTone.frequency * MULTIPLIER
        } else { return DEFAULT_FREQUENCY - DEFAULT_FREQUENCY * MULTIPLIER }
    }
    private var high: Double {
        if (centerTone) != nil {
            return centerTone.frequency + centerTone.frequency * MULTIPLIER
        } else { return DEFAULT_FREQUENCY + DEFAULT_FREQUENCY * MULTIPLIER }
    }
    
    open var engine: AVAudioEngine!
    private(set) var tones: [AVTonePlayerUnit?] = []
    private(set) var centerTone: AVTonePlayerUnit!
    
    /**
        The tonal frequency in the center of the frequency range
        - set: Set the frequency of all the tones uniformly based on the difference of the slider
     */
    open var centerToneFrequency: Double {
        get {
            return centerTone.frequency
        }
        set {
            centerTone.frequency = newValue
            for (index, tone) in tones.enumerated() {
                tone?.frequency = calculateFrequency(at: index)
            }
        }
    }
    
    /// Shared singleton instance for calling frequency methods
    open static var shared = FrequencyManager()
    
    private init() {
        setupEngine()
        centerTone = tones[TONE_RANGE / 2]
    }
    
    /// Plays all of the tones at once
    func play() {
        for tone in tones {
            guard let tone = tone else { fatalError() }
            tone.play()
        }
    }
    
    func stop() {
        for tone in tones {
            guard let tone = tone else { fatalError() }
            tone.stop()
        }
    }
    
    private func setupEngine() {
        engine = AVAudioEngine()
        generateTones()
        
        do {
            try engine.start()
        } catch let error as NSError {
            print(error)
        }
    }
    
    /// Generates all the tones in the range ±25% of the center frequency
    ///
    /// - Parameter amount: range of steps to loop through
    private func generateTones() {
        for index in 0...TONE_RANGE {
            let tone = AVTonePlayerUnit()
            tone.frequency = calculateFrequency(at: index)
            connect(tone: tone)
            tones.append(tone)
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
