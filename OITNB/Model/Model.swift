//
//  Model.swift
//  OITNB
//
//  Created by Raffaele Siciliano on 11/01/23.
//

import Foundation
import SwiftUI

enum Category {
    case shot, beer, wine, lightCocktail, midCocktail, strongCocktail
}

struct Drink : Identifiable, Hashable {
    let id = UUID()
    var category : Category
    var name : String
    var alcoholByVolume : Double
    var milliliters : Double
    var isFavorite : Bool = false
    var iconName : String
}

class AppData : ObservableObject {
    
    // MARK: List of Drinks
    @Published var allDrinks : [Drink] =
[Drink(category: .lightCocktail,name: "Mimosa",alcoholByVolume: 12.0,milliliters: 150.0,iconName: ""),
 Drink(category: .lightCocktail,name: "Aperol Spritz",alcoholByVolume: 11.0,milliliters: 150.0,iconName: ""),
 Drink(category: .lightCocktail, name: "Moscow Mule", alcoholByVolume: 12.0, milliliters: 175.0, iconName: ""),
 Drink(category: .lightCocktail, name: "Cuba Libre", alcoholByVolume: 12.0, milliliters: 180.0, iconName: ""),
 Drink(category: .lightCocktail, name: "Pina Colada", alcoholByVolume: 17.0, milliliters: 130.0, iconName: ""),
 Drink(category: .lightCocktail, name: "Gin Tonic", alcoholByVolume: 17.0, milliliters: 140.0, iconName: ""),
 Drink(category: .lightCocktail, name: "Mojito", alcoholByVolume: 18.0, milliliters: 180.0, iconName: "")
]
    
    // MARK: Functions
    func calculateBac(drink: Drink, myWeight: Double, myGender: String, haveEat: Bool, bacValue: String) -> Double {
        // Calculate the grams of alcohol in a drink
        let gramsOfAlcohol = ((drink.alcoholByVolume * 0.8) * (drink.milliliters / 100))
        // Check the coefficient to calculate the BAC
        var coefficientC : Double = 0.0
        if myGender == "Male" {
            if haveEat {
                coefficientC = 1.2
            } else {
                coefficientC = 0.7
            }
        } else if myGender == "Female" {
            if haveEat {
                coefficientC = 0.9
            } else {
                coefficientC = 0.5
            }
        }
        let bloodAlcoholConcentration = gramsOfAlcohol / (myWeight * coefficientC)
        // Check if the BAC value is 0.0, if not, add the actual BAC value with the new one.
        if bacValue != "0.000" {
            return bloodAlcoholConcentration + Double(bacValue)!
        } else {
            return bloodAlcoholConcentration
        }
    }
    
    func addToFavorite(drink: Drink) {
        let index = allDrinks.firstIndex{$0.id == drink.id}
        allDrinks[index!].isFavorite.toggle()
    }
    
}
