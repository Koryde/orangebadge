//
//  DrankListView.swift
//  OITNB
//
//  Created by Raffaele Siciliano on 26/01/23.
//

import SwiftUI

struct DrankListView: View {
    @EnvironmentObject var vm: DrinkViewModel
    @AppStorage("myGender") var myGender : String = ""
    @AppStorage("myWeight") var myWeight : Double = 0.0
    @AppStorage("bacValue") var bacValue : String = "0.000"

    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.drankArray){
                    drink in
                    DrankRowView(drink: drink)
                        .swipeActions(allowsFullSwipe: false) {
                            Button {
                                vm.removeDrinkFromDrank(drink: drink)
                                if vm.drankArray.isEmpty {
                                    bacValue = "0.000"
                                } else {
                                    bacValue = String(vm.calculateBac(drink: drink, myWeight: myWeight, myGender: myGender, haveEat: false, bacValue: bacValue, drankListOpen: true))
                                }
                            } label: {
                                Image(systemName: "trash")
//                                Text("Delete")
                            }.tint(.red)
                            
                        }
                }
            }
            Spacer()
            .navigationTitle("Drinks you had")
        }
    }
}

struct DrankRowView: View {
    
    @EnvironmentObject var vm: DrinkViewModel
    var drink: Drink
    @State private var counter = 0
    
    var body: some View {
        HStack {
            HStack {
                Image(drink.category.listIconName)
                VStack(alignment: .leading) {
                    Text(drink.name)
                        .bold()
                    Text(String(format: "%.1f", drink.alcoholByVolume))
                        .foregroundColor(.secondary)
                }
            }
            Spacer()
            
//            Stepper("\(drink.drinkCounter)", onIncrement: {
//                vm.increaseDrinkCounter(drink: drink)
//            }, onDecrement: {
//                if drink.drinkCounter > 0 {
//                    vm.decreaseDrinkCounter(drink: drink)
//                }
//            })
        }
        .padding(.horizontal)
//        .onChange(of: drink.drinkCounter) { _ in
//            counter = drink.drinkCounter}
//        .onAppear {
//            counter = drink.drinkCounter
//        }
        
    }
}


//struct DrankListView_Previews: PreviewProvider {
//    static var previews: some View {
//        DrankListView()
//    }
//}
