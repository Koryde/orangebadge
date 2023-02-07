//
//  Carousel.swift
//  OITNB
//
//  Created by Andrea Masturzo on 11/01/23.
//

import SwiftUI

struct Carousel: View {
    let pageWidth: CGFloat
    @EnvironmentObject var drinkViewModel: DrinkViewModel
    @State private var offset: CGFloat = 0
    @State private var index = 0
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center, spacing: 1) {
                ForEach(drinkViewModel.carouselElements.indices, id: \.self) { index in
                    self.drinkViewModel.carouselElements[index]
                        .frame(width: self.pageWidth, height: nil)
                }
            }
        }
        .content.offset(x: offset)
        .frame(width: pageWidth, height: nil, alignment: .leading)
        .gesture(
            DragGesture()
                .onChanged { value in
                    self.offset = value.translation.width - (CGFloat(self.index) * self.pageWidth)
                }
                .onEnded { value in
                    let newIndex = self.newIndex(-value.translation.width, currentIndex: self.index)
                    self.index = newIndex
                    withAnimation { self.offset = -(CGFloat(self.index) * self.pageWidth) }
                }
        )
    }
    
    // this allows the snapping of the element in the middle of the screen
    private func newIndex(_ translation: CGFloat, currentIndex: Int) -> Int {
        let snapDistance = pageWidth / 2
        // this allows going back to first item when last is reached
        let newIndex: Int
        if translation > -snapDistance {
            newIndex = currentIndex + 1 >= drinkViewModel.carouselElements.count ? 0 : currentIndex + 1
        } else if translation < snapDistance {
            newIndex = currentIndex - 1 < 0 ? drinkViewModel.carouselElements.count - 1 : currentIndex - 1
        } else {
            newIndex = currentIndex
        }
        return newIndex
    }
}

struct CarouselElement: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var drinkViewModel : DrinkViewModel
    
    
    var drink: Drink
    
    var body: some View {
        Button(action: {
            drinkViewModel.bacValue = String(String(drinkViewModel.calculateBac(drink: drink, myWeight: drinkViewModel.myWeight, myGender: drinkViewModel.myGender, haveEat: drinkViewModel.haveEat, bacValue: drinkViewModel.bacValue, drankListOpen: false)).prefix(5))
            drinkViewModel.addDrinkToDrank(drink: drink)
            drinkViewModel.saveLastDrinkDate()
            print(drink)
        }, label: {
            ZStack {
                Circle()
                    .foregroundColor(Color("MainColor"))
                VStack {
                    colorScheme == .light ?
                    Image(drink.category.iconName)
                    :
                    Image(drink.category.iconNameBlack)
                    Text(drink.name)
                        .foregroundColor(Color("InvertText"))
                }
            }
        })
    }
}
