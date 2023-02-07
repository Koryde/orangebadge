//
//  DrankListView.swift
//  OITNB
//
//  Created by Raffaele Siciliano on 26/01/23.
//

import SwiftUI


struct DrankListView: View {
    @EnvironmentObject var drinkViewModel: DrinkViewModel
    @State private var showingAlert : Bool = false

    var body: some View {
        
        NavigationStack {
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
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading, content: {
                    Text("Drinks you had")
                        .font(.largeTitle)
                        .padding(.top)
                })
                ToolbarItem(placement: .navigationBarTrailing, content: {
                        Button {
                            showingAlert = true
                        } label: {
                            Image(systemName: "trash")
                                .tint(.red)
                     .alert("Are you sure you want to remove all the drinks?", isPresented: $showingAlert) {
                                    Button ("Cancel", role: .destructive){ }
                             .foregroundColor(.red)
                         
                                    Button("OK", role: .cancel) {
                                        drinkViewModel.resetCount()
                                    }
                                }
                    }
                        .padding(.top)
                })
            }
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
