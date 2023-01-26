//
//  Carousel.swift
//  OITNB
//
//  Created by Andrea Masturzo on 11/01/23.
//

import SwiftUI

struct Carousel: View {
    let pageWidth: CGFloat
    @EnvironmentObject var vm: DrinkViewModel
    @State private var offset: CGFloat = 0
    @State private var index = 0
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center, spacing: 1) {
                ForEach(vm.carouselElements.indices, id: \.self) { index in
                    self.vm.carouselElements[index]
                        .frame(width: self.pageWidth, height: nil)
                }
            }
        }
        .content.offset(x: offset)
        .frame(width: pageWidth, height: nil, alignment: .leading)
//        .onAppear {
//            carouselElements = vm.carouselElements
//        }
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
//        .onReceive(vm.$carouselElements) { _ in
//            print("on receive")
//            carouselElements = vm.carouselElements
//        }
    }
    
    // this allows the snapping of the element in the middle of the screen
    private func newIndex(_ translation: CGFloat, currentIndex: Int) -> Int {
        let snapDistance = pageWidth / 2
        // this allows going back to first item when last is reached
        let newIndex: Int
        if translation > -snapDistance {
            newIndex = currentIndex + 1 >= vm.carouselElements.count ? 0 : currentIndex + 1
        } else if translation < snapDistance {
            newIndex = currentIndex - 1 < 0 ? vm.carouselElements.count - 1 : currentIndex - 1
        } else {
            newIndex = currentIndex
        }
        return newIndex
    }
}

struct CarouselElement: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var drinkViewModel : DrinkViewModel
    
    @AppStorage("bacValue") var bacValue : String = "0.000"
    @AppStorage("myGender") var myGender : String = ""
    @AppStorage("myWeight") var myWeight : Double = 0.0
    
    var drink: Drink
    
    var body: some View {
        Button(action: {
            bacValue = String(String(drinkViewModel.calculateBac(drink: drink, myWeight: myWeight, myGender: myGender, haveEat: true, bacValue: bacValue, drankListOpen: false)).prefix(5))
            drinkViewModel.addDrinkToDrank(drink: drink)
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
