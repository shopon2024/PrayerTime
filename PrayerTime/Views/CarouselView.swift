//
//  CarouselView.swift
//  PrayerTime
//
//  Created by Habibur Rahman on 17/3/21.
//

import SwiftUI

struct CarouselView: View {
    @State var activeCardIndex: CGFloat = 0
    @State var screenDragOffset: CGFloat = 0.0
    @GestureState var isLongPress = false

    let prayers: [Prayer]
    let spacing: CGFloat = 16
    let widthOfHiddenCards: CGFloat = 32
    let numberOfCards: CGFloat = 5
    let totalSpacing: CGFloat = 4*16 // (numberOfCards - 1)*spacing

    var body: some View {
        let cardWidth: CGFloat = UIScreen.main.bounds.width - (widthOfHiddenCards*2) - (spacing*2)
        let totalCanvasWidth = (cardWidth * numberOfCards) + totalSpacing
        let xOffsetToShift = (totalCanvasWidth - UIScreen.main.bounds.width)/2
        let leftPadding = widthOfHiddenCards + spacing
        let totalMovement = cardWidth + spacing
        let activeOffset = xOffsetToShift + leftPadding - (totalMovement * activeCardIndex)
        let calculatedOffset = activeOffset + screenDragOffset
        
        HStack(spacing: spacing) {
            ForEach(prayers) { prayer in
                PrayerCard(prayer: prayer)
                    .frame(width: cardWidth)
                    .transition(AnyTransition.slide)
                    .animation(.spring())
            }
        }
        .offset(x: calculatedOffset)
        .gesture(
            DragGesture()
                .updating($isLongPress) { currentState, _, _ in
                    DispatchQueue.main.async {
                        self.screenDragOffset = currentState.translation.width
                    }
                    
                }
                .onEnded { value in
                    screenDragOffset = 0
                    
                    if value.translation.width < -50  && activeCardIndex < (numberOfCards - 1.0){
                        activeCardIndex += 1
                    } else if value.translation.width > 50  && activeCardIndex > 0{
                        activeCardIndex -= 1
                    }
                }
                
        )
        
    }
}

struct CarouselView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselView(prayers: Prayer.stubs)
    }
}
