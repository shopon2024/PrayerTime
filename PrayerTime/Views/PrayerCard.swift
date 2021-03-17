//
//  PrayerCard.swift
//  PrayerTime
//
//  Created by Habibur Rahman on 16/3/21.
//

import SwiftUI

struct PrayerCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8){
            HStack {
                LinearGradient(gradient: Gradient(colors: [.appBlue, .appGray]), startPoint: .leading, endPoint: .trailing)
                    .mask(Image(systemName: "moon.stars.fill"))
                    .font(Font.system(size: 26, weight: .bold))
                    .frame(width: 50, height: 50)
                    .padding([.leading, .bottom], 4)

                Spacer()

                Image(systemName: "bell")
                    .font(Font.system(size: 12, weight: .medium))
                    .foregroundColor(Color.green)
                    .frame(width: 44, height: 44)
                    .background(
                        Color.green
                            .opacity(0.2)
                            .cornerRadius(8)
                            .padding(4)
                    )
            }
            .padding([.leading, .trailing], 4)
            
            Text("Upcoming Payer")
                .foregroundColor(.appGray)
                .font(.body)
                .padding(.leading, 8)
            
            Text("Magrib at 21:02")
                .foregroundColor(.appBlack)
                .font(.title)
                .bold()
                .padding([.leading, .bottom], 8)
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct PrayerCard_Previews: PreviewProvider {
    static var previews: some View {
        PrayerCard()
            .frame(width: 300, height: 100, alignment: .center)
    }
}
