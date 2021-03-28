//
//  HomeView.swift
//  PrayerTime
//
//  Created by Habibur Rahman on 16/3/21.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = HomeViewModel()
    @State private var showingSheet = false
    var shouldUpdatePrayerTimes = false {
        didSet {
            if shouldUpdatePrayerTimes {
                viewModel.update()
            }
        }
    }
    private var gmtOffset: String =  {
        let seconds = TimeZone.current.secondsFromGMT()
        let minutes = abs(seconds/60) % 60
        let hours = seconds/3600
        
        return String(format: "GMT%+.2d:%.2d", hours, minutes)
    }()

    var body: some View {
        VStack(spacing: 8) {
            topView()
            CarouselView(prayers: viewModel.prayerTimes)
                .offset(y: -80)
            
            bottonView()
                .background(Color.appBackground)
                .offset(y: -72)
            
           Spacer()
        }
    }
    
    func topView() -> some View {
        return ZStack(alignment: .top) {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [.appBlue, .appPink, .appPurple]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
                
             
                VStack {
                    Spacer()
                    Image("mosque")
                        .resizable()
                        .aspectRatio(1.8, contentMode: .fit)
                }
            }
            .frame(height: 400)
            .ignoresSafeArea()
            
            HStack {
                Spacer()
                Button(action: {
                    showingSheet.toggle()
                }){
                    Image(systemName: "slider.vertical.3")
                        .font(Font.system(size: 16))
                        .foregroundColor(.white)
                        .frame(width: 44, height: 44, alignment: .center)
                        .background(
                            Color.white
                                .opacity(0.2)
                                .cornerRadius(4)
                                .padding(4)
                        )
                }
                .sheet(isPresented: $showingSheet){
                    SettingsView(
                        location: viewModel.locationManager.currentLocation,
                        city: viewModel.locationManager.currentCity)
                }
            }
            .padding([.trailing], 16)
            
            VStack {
                Text("Prayer Time")
                    .font(Font.system(.title2, design: .rounded))
                    .bold()
                    .foregroundColor(.white)
                ZStack {
                    Circle()
                        .stroke(Color.appGray, style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
                        .frame(width: 150, height: 150, alignment: .center)
                        .background(
                            Text("Upcoming after \n Asr prayer")
                                .font(Font.system(.callout, design: .rounded))
                                .bold()
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                        )
                }
                
            }
            
        }
    }
    
    func bottonView() -> some View {
        return VStack(spacing: 6) {
            HStack {
                DateCardView(title: "Day", date: Date())

                CardView(title: "Time", value: viewModel.gmtOffset)
            }
            .padding([.leading, .trailing], 8)
            
            HStack {
                CardView(title: "Qibla Direction", value: "162°")

                CardView(title: "Location", value: viewModel.locationManager.currentCity ?? "")
            }
            .padding([.leading, .trailing], 8)
        }
    }
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
