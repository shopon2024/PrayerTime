//
//  SettingsViewModel.swift
//  PrayerTime
//
//  Created by Habibur Rahman on 26/3/21.
//

import Foundation
import AKPrayerTime

final class SettingsViewModel: ObservableObject {
    let calculationMethods: [CalculationMethod] = [.mwl, .isna, .egypt, .makkah, .karachi, .tehran, .jafari]
    @Published var selectedMethodIndex: Int = 4
    
    let asrMethods: [AsrJuristicMethod] = [.shafii, .hanafi]
    @Published var selectedAsrMethodIndex = 0
    
    let midnightMethods: [MidnightMethod] = [.standard, .jafari]
    @Published var selectedMidnightMethodIndex = 0
    
    let higherLatutudeAdjustments: [HigherLatutudeAdjustment] = [.angleBased, .oneSeventh, .midNight, .none]
    @Published var selectedHigherLatutudeAdjustmentIndex = 0
    
    lazy var gmtOffset: String =  {
        let seconds = TimeZone.current.secondsFromGMT()
        let minutes = abs(seconds/60) % 60
        let hours = seconds/3600
        
        return String(format: "%+.2d:%.2d", hours, minutes)
    }()
    
    func onAppear() {
        selectedMethodIndex = calculationMethods.firstIndex(of: Config.shared.calcMethod) ?? 0
        selectedMidnightMethodIndex = midnightMethods.firstIndex(of: Config.shared.midnight) ?? 0
        selectedAsrMethodIndex = asrMethods.firstIndex(of: Config.shared.asrMethod) ?? 0
        selectedHigherLatutudeAdjustmentIndex = higherLatutudeAdjustments.firstIndex(of: Config.shared.highLat) ?? 0
    }
    
    func updateConfig() {
        Config.shared.calcMethod = calculationMethods[selectedMethodIndex]
        Config.shared.asrMethod = asrMethods[selectedAsrMethodIndex]
        Config.shared.midnight = midnightMethods[selectedMidnightMethodIndex]
        Config.shared.highLat = higherLatutudeAdjustments[selectedHigherLatutudeAdjustmentIndex]
    }
}
