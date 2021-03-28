//
//  CardView.swift
//  PrayerTime
//
//  Created by Habibur Rahman on 20/3/21.
//

import SwiftUI

struct CardView: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack {
                Text(title)
                    .font(Font.system(.body, design: .rounded))
                    .bold()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.appGray)
            
            
                Text(value)
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

extension View {
    func cardView(cornerRadius: CGFloat = 4, shadow: CGFloat = 1) -> some View {
        return self
            .cornerRadius(cornerRadius)
            .shadow(radius: shadow)
    }
}
