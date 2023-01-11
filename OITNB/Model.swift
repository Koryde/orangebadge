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
    func calculateBac(drink: Drink, myWeight: Double, myGender: String, haveEat: Bool) -> Double {
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
        print(coefficientC)
        let bloodAlcoholConcentration = gramsOfAlcohol / (myWeight * coefficientC)
        return bloodAlcoholConcentration
    }
}
