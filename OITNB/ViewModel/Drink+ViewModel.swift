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
    
    
    // MARK: API Request

    
    //Get request
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
    
    //Post request
    func postDrink(drink: Drink) async{
        do{
            let url = URL(string: "http://127.0.0.1:8080/drinksJson" )
            var request = URLRequest(url: url!)
            request.httpMethod = "POST"
            request.setValue("Bearer ??", forHTTPHeaderField: "Authorization")
            let (data, _) = try await URLSession.shared.data(for: request)
        
        } catch{
            print(error.localizedDescription)
        }
        
    }
    
    
}
