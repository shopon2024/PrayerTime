//
//  DateCardView.swift
//  PrayerTime
//
//  Created by Habibur Rahman on 23/3/21.
//

import SwiftUI

struct DateCardView: View {
    let title: String
    let date: Date
    var body: some View {
        VStack {
            Text(title)
                .font(Font.system(.body, design: .rounded))
                .bold()
                .frame(maxWidth: .infinity)
                .foregroundColor(.appGray)
            
            
            Text(date, style: .date)
                .font(Font.system(.title3, design: .rounded))
                .bold()
                .frame(maxWidth: .infinity)
                .foregroundColor(.black)
            
        }
        .padding()
        .background(Color.white)
        .cardView()
    }
}
