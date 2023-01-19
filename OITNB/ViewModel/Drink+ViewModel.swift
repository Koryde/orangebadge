//
//  Drink+ViewModel.swift
//  OITNB
//
//  Created by Raffaele Siciliano on 16/01/23.
//

import Foundation
import SwiftUI

class DrinkViewModel : ObservableObject {
    
    // MARK: List of Drinks
    @Published var allDrinks : [Drink] = []
//    [//MEDIUM DRINKS LIST
//     Drink(category: .mediumDrink,name: "Mimosa",alcoholByVolume: 12.0,milliliters: 150.0),
//     Drink(category: .mediumDrink,name: "Aperol Spritz",alcoholByVolume: 11.0,milliliters: 150.0),
//     Drink(category: .mediumDrink, name: "Moscow Mule", alcoholByVolume: 12.0, milliliters: 175.0),
//     Drink(category: .mediumDrink, name: "Pina Colada", alcoholByVolume: 17.0, milliliters: 130.0),
//     Drink(category: .mediumDrink, name: "Gin Tonic", alcoholByVolume: 17.0, milliliters: 140.0),
//     Drink(category: .mediumDrink, name: "Mojito", alcoholByVolume: 18.0, milliliters: 180.0),
//     Drink(category: .mediumDrink, name: "Classic Sangria", alcoholByVolume: 16.0, milliliters: 180.0),
//     //SHORT DRINKS LIST
//     Drink(category: .shortDrink, name: "Negroni", alcoholByVolume: 29.0, milliliters: 90.0),
//     Drink(category: .shortDrink, name: "Angelo Azzurro", alcoholByVolume: 35.0, milliliters: 110.0),
//     Drink(category: .shortDrink, name: "Manhattan", alcoholByVolume: 30.0, milliliters: 70.0),
//     Drink(category: .shortDrink, name: "Dry Martini", alcoholByVolume: 29.8, milliliters: 70.0),
//     Drink(category: .shortDrink, name: "Godfather", alcoholByVolume: 30.0, milliliters: 70.0),
//     Drink(category: .shortDrink, name: "Caipirinha", alcoholByVolume: 36.0, milliliters: 60.0),
//     Drink(category: .shortDrink, name: "Margarita", alcoholByVolume: 25.4, milliliters: 85.0),
//     Drink(category: .shortDrink, name: "Whiskey Sour", alcoholByVolume: 13.3, milliliters: 90.0),
//     //LONG DRINKS LIST
//     Drink(category: .longDrink, name: "Cuba Libre", alcoholByVolume: 12.0, milliliters: 180.0),
//     Drink(category: .longDrink, name: "Daiquiri", alcoholByVolume: 17.0, milliliters: 80.0),
//     //GENERIC BEERS LIST
//     Drink(category: .beer, name: "Small Beer", alcoholByVolume: 7.5, milliliters: 25.0),
//     Drink(category: .beer, name: "Big Beer", alcoholByVolume: 7.5, milliliters: 50.0),
//     //WINES LIST
//     Drink(category: .wine, name: "Red Wine", alcoholByVolume: 13.5, milliliters: 200.0),
//     Drink(category: .wine, name: "White Wine", alcoholByVolume: 13.5, milliliters: 150.0),
//     Drink(category: .wine, name: "Rosé Wine", alcoholByVolume: 12.0, milliliters: 200.0),
//     //SHOTS LIST
//     Drink(category: .shot, name: "Tequila", alcoholByVolume: 40.0, milliliters: 30.0),
//     Drink(category: .shot, name: "Jägermeister", alcoholByVolume: 35.0, milliliters: 30.0),
//     Drink(category: .shot, name: "Fireball Cinnamon Whiskey", alcoholByVolume: 33.3, milliliters: 30.0),
//     Drink(category: .shot, name: "Sambuca", alcoholByVolume: 38.0, milliliters: 30.0),
//     Drink(category: .shot, name: "Asbinthe", alcoholByVolume: 65.0, milliliters: 30.0),
//     Drink(category: .shot, name: "Goldschlager", alcoholByVolume: 40.0, milliliters: 30.0),
//     Drink(category: .shot, name: "Bacardi 151", alcoholByVolume: 75.5, milliliters: 15.0),
//     Drink(category: .shot, name: "Rakia", alcoholByVolume: 50.0, milliliters: 30.0),
//     Drink(category: .shot, name: "Smooth Vodka", alcoholByVolume: 40.0, milliliters: 30.0),
//     Drink(category: .shot, name: "Whiskey", alcoholByVolume: 40.0, milliliters: 30.0),
//     Drink(category: .shot, name: "Rum", alcoholByVolume: 40.0, milliliters: 30.0),
//     Drink(category: .shot, name: "B-52", alcoholByVolume: 27.5, milliliters: 30.0),
//     Drink(category: .shot, name: "Latte di Suocera", alcoholByVolume: 70.0, milliliters: 30.0)
//    ]
    
    @Published var carouselElements: [CarouselElement] = []

    init() {
        for _ in allDrinks {
            carouselElements = allDrinks.filter { $0.isFavorite }.map { CarouselElement(drink: $0) }
        }
    }
   
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
        } else {
            if haveEat {
                coefficientC = 1.05
            } else {
                coefficientC = 0.6
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
    
    func updateCarouselElements() {
            carouselElements = allDrinks.filter { $0.isFavorite }.map { CarouselElement(drink: $0) }
        }
    
    func addToFavorite(drink: Drink) {
        let index = allDrinks.firstIndex{$0.id == drink.id}
        allDrinks[index!].isFavorite.toggle()
        self.updateCarouselElements()
    }
    
    
    // MARK: GET Request
    
    func getDrink() async  {
        
        let url = URL(string: "http://127.0.0.1:8080/drinksJson")!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                // handle error
                return
            }
            do {
//                let drinks = try JSONDecoder().decode([Drink].self, from: data)
                let json = try JSONDecoder().decode([Drink].self, from: data)
                DispatchQueue.main.async {
                    self.allDrinks = json
                }
                print(json)
                // Use json here
            } catch {
                // handle error
            }
        }.resume()
    }
}
