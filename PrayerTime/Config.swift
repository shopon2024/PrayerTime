//
//  Config.swift
//  PrayerTime
//
//  Created by Habibur Rahman on 15/3/21.
//

import Foundation
import AKPrayerTime

class Config {
    static private(set) var global = Config()
    
    
    // ================================================
    // Test Values
    // ------------------------------------------------
    // (lat: 23.810332, lng: 90.4125181)    ~~> tz: +6
    // (lat: 43.6605, lng: -79.4633)        ~~> tz: -5
    // ================================================
    var coordinate: Coordinate = .init(lat: 23.810332, lng: 90.4125181)
    var address: String? = "Dhaka"
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
