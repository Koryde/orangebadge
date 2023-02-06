//
//  DrankListView.swift
//  OITNB
//
//  Created by Raffaele Siciliano on 26/01/23.
//

import SwiftUI


struct DrankListView: View {
    @EnvironmentObject var drinkViewModel: DrinkViewModel

    var body: some View {
        
        NavigationStack {
            
            HStack {
                Spacer()
                Text("Remove all the drinks")
                    .fontWeight(.bold)
                Button {
                    drinkViewModel.resetCount()
                } label: {
                    Image(systemName: "trash")
            }.tint(.red)
            }
            
            List {
                ForEach(drinkViewModel.drankArray){
                    drink in
                    DrankRowView(drink: drink)
                        .swipeActions(allowsFullSwipe: false) {
                            Button {
                                drinkViewModel.removeDrinkFromDrank(drink: drink)
                                if drinkViewModel.drankArray.isEmpty {
                                    drinkViewModel.bacValue = "0.000"
                                } else {
                                    drinkViewModel.bacValue = String(drinkViewModel.calculateBac(drink: drink, myWeight: drinkViewModel.myWeight, myGender: drinkViewModel.myGender, haveEat: drinkViewModel.haveEat, bacValue: drinkViewModel.bacValue, drankListOpen: true))
                                }
                            } label: {
                                Image(systemName: "trash")
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
    
    @EnvironmentObject var drinkViewModel: DrinkViewModel
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
        }
        .padding(.horizontal)
    }
}


//struct DrankListView_Previews: PreviewProvider {
//    static var previews: some View {
//        DrankListView()
//    }
//}
