//
//  HomeViewModel.swift
//  PrayerTime
//
//  Created by Habibur Rahman on 27/3/21.
//

import Foundation
import AKPrayerTime
import Combine

final class HomeViewModel: ObservableObject {
    @Published var locationManager = LocationManager()
    @Published var prayerTimes = [Prayer]()

    var storage = Set<AnyCancellable>()

    lazy var gmtOffset: String =  {
        let seconds = TimeZone.current.secondsFromGMT()
        let minutes = abs(seconds/60) % 60
        let hours = seconds/3600
        
        return String(format: "GMT%+.2d:%.2d", hours, minutes)
    }()
    
    init() {
        locationManager.start()
        
        locationManager.$currentLocation.sink { [weak self] coordinate in
            let newCoordinate = (coordinate?.latitude, coordinate?.longitude)
            self?.updatePrayerTimes(for: newCoordinate)
        }.store(in: &self.storage)
    }
    
    private func updatePrayerTimes(for coordinate: (lat: Double?, long: Double?)) {
        let akPrayerTime = AKPrayerTime(lat: coordinate.lat ?? 0, lng: coordinate.long ?? 0)
        akPrayerTime.calculationMethod = Config.shared.calcMethod
        akPrayerTime.asrJuristic = Config.shared.asrMethod
        akPrayerTime.timeZone = Config.shared.gmtOffset
        akPrayerTime.highLatitudeAdjustment = Config.shared.highLat
        akPrayerTime.setMidnightMethod(Config.shared.midnight)
        
        var id = 0
        if let times = akPrayerTime.getPrayerTimes() {
            let pTimes = akPrayerTime.sorted(times)
            prayerTimes.removeAll()
            for(key, value) in pTimes {
                let waqt: Waqt
                switch key {
                case .fajr:
                    waqt = Waqt.fajr
                    let prayer = Prayer(id: id, waqt: waqt, time: "\(value.toTime12())")
                    prayerTimes.append(prayer)
                    id += 1
                case .dhuhr:
                    waqt = Waqt.duhr
                    let prayer = Prayer(id: id, waqt: waqt, time: "\(value.toTime12())")
                    prayerTimes.append(prayer)
                    id += 1
                case .asr:
                    waqt = Waqt.asr
                    let prayer = Prayer(id: id, waqt: waqt, time: "\(value.toTime12())")
                    prayerTimes.append(prayer)
                    id += 1
                case .maghrib:
                    waqt = Waqt.magrib
                    let prayer = Prayer(id: id, waqt: waqt, time: "\(value.toTime12())")
                    prayerTimes.append(prayer)
                    id += 1
                case .isha:
                    waqt = Waqt.isha
                    let prayer = Prayer(id: id, waqt: waqt, time: "\(value.toTime12())")
                    prayerTimes.append(prayer)
                    id += 1
                default:
                    break
                }
            }
        }
    }
    
    func update() {
//        let coordinate = (locationManager?.latitude, coordinate?.longitude)
//        self?.updatePrayerTimes(for: newCoordinate)
//        updatePrayerTimes(for: <#T##(lat: Double?, long: Double?)#>)
    }
}
