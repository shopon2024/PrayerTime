//
//  Prayer.swift
//  PrayerTime
//
//  Created by Habibur Rahman on 18/3/21.
//

import Foundation

struct Prayer: Identifiable {
    let id: Int
    let name: String
    let time: String
}

extension Prayer {
    static let stubs: [Prayer] = [
        Prayer(id: 0, name: "Fajr", time: "5:30 AM"),
        Prayer(id: 0, name: "Dhur", time: "1:15 PM"),
        Prayer(id: 0, name: "Asr", time: "4:50 PM"),
        Prayer(id: 0, name: "Magrib", time: "6:10 PM"),
        Prayer(id: 0, name: "Isha", time: "8:15 PM")
    ]
}
