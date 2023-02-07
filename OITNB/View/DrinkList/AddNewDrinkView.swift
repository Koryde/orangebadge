//
//  AddNewDrinkView.swift
//  OITNB
//
//  Created by Andrea Masturzo on 30/01/23.
//

import SwiftUI
// Category
// Name
// alcoholByVolume
// milliliters
// isFavorite
struct AddNewDrinkView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var drinkViewModel: DrinkViewModel
    
    @State var drinkName = ""
    @State var category: Category = .shot
    @State var alcohol = 0.0
    @State var milliliters = 0.0
    @State var isFavorite = false
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Drink Name", text: $drinkName)
                
                // Category picker
                Picker("Drink Category", selection: $category, content: {
                    ForEach(Category.allCases, id: \.self) { category in
                        Text(category.rawValue)
                    }
                })
                
                // Alcohol picker
                Picker("Alcohol by volume", selection: $alcohol, content: {
                    ForEach(Array(stride(from: 0.0, to: 100.0, by: 0.5)), id: \.self) { value in
                        Text(String(format: "%.1f", value))
                    }
                })
                
                // Milliliters picker
                Picker("Milliliters", selection: $milliliters, content: {
                    ForEach(Array(stride(from: 0.0, to: 500.0, by: 5)), id: \.self) { value in
                        Text(String(format: "%.1f", value))
                    }
                })
                
                Toggle("Add to favorites", isOn: $isFavorite)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading, content: {
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }, label: {
                                Text("Cancel")
                            })
                        })
                        
                        ToolbarItem(placement: .navigationBarTrailing, content: {
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                                drinkViewModel.createDrink(drink: Drink(category: category, name: drinkName, alcoholByVolume: alcohol, milliliters: milliliters, isFavorite: isFavorite))
                            }, label: {
                                Text("Save")
                            })
                        })
                    }
            }
        }
        .navigationTitle("Add New Drink")
    }
}

