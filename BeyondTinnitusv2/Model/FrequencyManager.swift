//
//  FrequencyManager.swift
//  BeyondTinnitusv2
//
//  Created by Huyanh Hoang on 2016. 12. 13..
//  Copyright © 2016년 teamMedApp. All rights reserved.
//

import Foundation
import AVFoundation

final class FrequencyManager {
    
    private let TONE_RANGE = 50
    open var engine: AVAudioEngine!
    private var tones: [AVTonePlayerUnit?] = []
    private(set) var centerTone: AVTonePlayerUnit!
    
    open var centerToneFrequency: Double {
        get {
            return centerTone.frequency
        }
        set {
            let difference = newValue - centerTone.frequency
            centerTone.frequency = newValue
            for tone in tones {
                tone?.frequency += difference
            }
        }
    }
    
    open static var shared = FrequencyManager()
    
    private init() {
        setupEngine()
        centerTone = tones[TONE_RANGE / 2]
    }
    
    private func setupEngine() {
        engine = AVAudioEngine()
        generateTones(usingRange: TONE_RANGE)
        
        do {
            try engine.start()
        } catch let error as NSError {
            print(error)
        }
    }
    
    private func generateTones(usingRange amount: Int) {
        for _ in 1...amount {
            let tone = AVTonePlayerUnit()
            connect(tone: tone)
            tones.append(tone)
        }
    }
    
    private func connect(tone: AVTonePlayerUnit) {
        let format = AVAudioFormat(standardFormatWithSampleRate: tone.sampleRate, channels: 1)
        let mixer = engine.mainMixerNode
        engine.attach(tone)
        engine.connect(tone, to: mixer, format: format)

    }
    
}
