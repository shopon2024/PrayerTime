//
//  Config.swift
//  PrayerTime
//
//  Created by Habibur Rahman on 15/3/21.
//

import Foundation
import AKPrayerTime

class Config {
    static let shared = Config()

    private init() {}

    var gmtOffset: Float = TimeZone.current.inHours()
    var calcMethod: CalculationMethod = .karachi
    var asrMethod: AsrJuristicMethod = .hanafi
    var highLat: HigherLatutudeAdjustment = .midNight
    var midnight: MidnightMethod = .standard

    var calcDate: Date = Date()
}

extension TimeZone {
    func inHours() -> Float {
        return Float(secondsFromGMT())/3600.0
    }
}
