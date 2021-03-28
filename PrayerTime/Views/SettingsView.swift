//
//  SettingsView.swift
//  PrayerTime
//
//  Created by Habibur Rahman on 20/3/21.
//

import SwiftUI
import CoreLocation
import AKPrayerTime

struct SettingsView: View {
    @Environment(\.presentationMode) var presentation
    @ObservedObject var viewModel = SettingsViewModel()
    
    private let currentLocation: CLLocationCoordinate2D?
    private let currentCity: String?
    
    init(location: CLLocationCoordinate2D?, city: String?) {
        currentCity = city
        currentLocation = location
    }
    
    var body: some View {
        NavigationView() {
            VStack(spacing: 0) {
                if currentLocation != nil {
                    MapView(coordinate: currentLocation!)
                        .frame(height: 200)
                        .ignoresSafeArea(.keyboard, edges: [.leading, .trailing])
                }

                Divider()
                
                Form {
                    Section(header: Text("Location")) {
                        HStack {
                            Text("Address")
                            Spacer()
                            Text(currentCity ?? "")
                        }
                        
                        HStack {
                            Text("GMT Offset")
                            Spacer()
                            Text(String(describing: viewModel.gmtOffset))
                        }
                    }
                    
                    Section(header: Text("Calculation")) {
                        Picker("Calculation Method", selection: $viewModel.selectedMethodIndex) {
                            ForEach(0..<viewModel.calculationMethods.count) { index in
                                Text(String(describing: viewModel.calculationMethods[index]).capitalized ).tag(index)
                            }
                        }
                        
                        Picker("Asr Method", selection: $viewModel.selectedAsrMethodIndex) {
                            ForEach(0..<viewModel.asrMethods.count) { index in
                                Text(String(describing: viewModel.asrMethods[index]).capitalized ).tag(index)
                            }
                        }
                        
                        Picker("Midnight Method", selection: $viewModel.selectedMidnightMethodIndex) {
                            ForEach(0..<viewModel.asrMethods.count) { index in
                                Text(String(describing: viewModel.midnightMethods[index]).capitalized ).tag(index)
                            }
                        }
                        
                        Picker("Higher Latitude Adjustment", selection: $viewModel.selectedHigherLatutudeAdjustmentIndex) {
                            ForEach(0..<viewModel.higherLatutudeAdjustments.count) { index in
                                Text(String(describing: viewModel.higherLatutudeAdjustments[index]).capitalized ).tag(index)
                            }
                        }
                    }
                    
                    Section() {
                        Button(action: {
                            viewModel.updateConfig()
                            presentation.wrappedValue.dismiss()
                        }, label: { Text("Apply") })
                        .frame(maxWidth: .infinity)
                    }
                }
            }
            .navigationTitle(Text("Settings"))
            .onAppear { viewModel.onAppear() }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(location: CLLocationCoordinate2D(latitude: 23.810332, longitude: 90.4125181), city: "Dhaka")
    }
}
