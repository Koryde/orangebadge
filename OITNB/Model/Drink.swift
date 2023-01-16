//
//  Model.swift
//  OITNB
//
//  Created by Raffaele Siciliano on 11/01/23.
//

import Foundation
import SwiftUI

enum Category : String, CaseIterable {
    case shot = "Shots"
    case beer = "Beers"
    case wine = "Wines"
    case shortDrink = "Short Drinks"
    case mediumDrink = "Medium Drinks"
    case longDrink = "Long Drinks"
    
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
    
    var listIconName : String {
        switch self {
        case .shot :
            return "OrangeShot"
        case .beer:
            return "OrangeBeer"
        case .wine:
            return "OrangeWine"
        case .shortDrink:
            return "OrangeCocktail"
        case .mediumDrink:
            return "OrangeCocktail"
        case .longDrink:
            return "OrangeCocktail"
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


