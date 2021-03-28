//
//  Prayer.swift
//  PrayerTime
//
//  Created by Habibur Rahman on 18/3/21.
//

import Foundation

struct Prayer: Identifiable {
    let id: Int
    let waqt: Waqt
    let time: String
}

enum Waqt {
    case fajr, duhr, asr, magrib, isha
    
    var name: String {
        String(describing: self).capitalized
    }
    
    var icon: String {
        switch self {
        case .fajr : return "sunrise"
        case .duhr: return "sun.max"
        case .asr: return "sun.min"
        case .magrib: return "sunset"
        case .isha: return "moon.stars.fill"
        }
    }
}

extension Prayer {
    static let stubs: [Prayer] = [
        Prayer(id: 0, waqt: .fajr, time: "5:30 AM"),
        Prayer(id: 1, waqt: .duhr, time: "1:15 PM"),
        Prayer(id: 2, waqt: .asr, time: "4:50 PM"),
        Prayer(id: 3, waqt: .magrib, time: "6:10 PM"),
        Prayer(id: 4, waqt: .isha, time: "8:15 PM")
    ]
}
