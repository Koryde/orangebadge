//
//  Model.swift
//  OITNB
//
//  Created by Raffaele Siciliano on 11/01/23.
//

import Foundation
import SwiftUI

enum Category : String, CaseIterable {
    case shot, beer, wine, shortDrink, mediumDrink, longDrink
    
    var name : String {
        switch self {
        case .shot :
            return "Shot"
        case .beer:
            return "Beer"
        case .wine:
            return "Wine"
        case .shortDrink:
            return "Short Drink"
        case .mediumDrink:
            return "Medium Drink"
        case .longDrink:
            return "Long Drink"
        }
    }
    var iconName : String {
        switch self {
        case .shot:
            return "DrinkingGlass"
        case .beer:
            return "BeerGlass"
        case .wine:
            return "WineGlass"
        case .shortDrink:
            return "CocktailGlass"
        case .mediumDrink:
            return ""
        case .longDrink:
            return ""
        }
    }
    
}

struct Drink : Identifiable, Hashable {
    let id = UUID()
    var category : Category
    var name : String
    var alcoholByVolume : Double
    var milliliters : Double
    var isFavorite : Bool = false
}


