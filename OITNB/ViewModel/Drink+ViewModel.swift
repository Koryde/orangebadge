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
    @Published var carouselElements: [CarouselElement] = []

    init() {
        for _ in readDrinks() {
            carouselElements = readDrinks().filter { $0.isFavorite }.map { CarouselElement(drink: $0) }
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
            carouselElements = readDrinks().filter { $0.isFavorite }.map { CarouselElement(drink: $0) }
        }
    
    
    // MARK: API Request

    func getDrink() async  {

        let url = URL(string: "http://127.0.0.1:8080/drinksJson")!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                // handle error
                return
            }
            do {
                let json = try JSONDecoder().decode([Drink].self, from: data)
                let fileName = "drinks.json"
                let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let fileURL = documentsDirectory.appendingPathComponent(fileName)
                print(json)
                // Use json here
                do {
                    let jsonData = try JSONEncoder().encode(json)
                    try jsonData.write(to: fileURL)
                    print("JSON data was saved to \(fileURL)")
                } catch {
                    print("Failed to write JSON data to file with error: \(error)")
                }

            } catch {
                // handle error
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    // MARK: Decode Local JSon
    
    func decodeLocalJSON() {
        if let path = Bundle.main.path(forResource: "startingDrinks", ofType: "json") {
            do {
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonDecoder = JSONDecoder()
                let json = try jsonDecoder.decode([Drink].self, from: jsonData)
                let fileName = "drinks.json"
                let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let fileURL = documentsDirectory.appendingPathComponent(fileName)
                do {
                    let jsonData = try JSONEncoder().encode(json)
                    try jsonData.write(to: fileURL)
                    print("JSON data was saved to \(fileURL)")
                } catch {
                    print("Failed to write JSON data to file with error: \(error)")
                }
            } catch {
                print(error)
            }
        }
    }

    
    // MARK: CRUD Operation for Drink
    
    
    private let fileManager = FileManager.default
    private let jsonDecoder = JSONDecoder()
    private let jsonEncoder = JSONEncoder()
    private var jsonFileURL: URL {
        let documentDirectory = try! fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        return documentDirectory.appendingPathComponent("drinks.json")
    }
    private var startingJsonURL : URL {
        let documentDirectory = try! fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        return documentDirectory.appendingPathComponent("startingDrinks.json")
    }
    
    /// Add a Drink to the JSON file.
    func appendDrinkToJSON(drink: Drink) {
        let fileManager = FileManager.default
        let documentDirectory = try! fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let jsonFileURL = documentDirectory.appendingPathComponent("drinks.json")

        // Try to read existing JSON data from the file
        guard let jsonData = try? Data(contentsOf: jsonFileURL) else {
            // If the file doesn't exist or there's an error reading it, create a new JSON array with the new drink
            let jsonEncoder = JSONEncoder()
            let newDrinks = [drink]
            let newJSONData = try! jsonEncoder.encode(newDrinks)
            try! newJSONData.write(to: jsonFileURL)
            return
        }

        // If the file does exist and we were able to read the JSON data, try to decode it as an array of drinks
        let jsonDecoder = JSONDecoder()
        let existingDrinks = try! jsonDecoder.decode([Drink].self, from: jsonData)

        // Append the new drink to the existing array
        var updatedDrinks = existingDrinks
        updatedDrinks.append(drink)

        // Encode the updated array as JSON data
        let jsonEncoder = JSONEncoder()
        let updatedJSONData = try! jsonEncoder.encode(updatedDrinks)

        // Write the updated JSON data to the file
        try! updatedJSONData.write(to: jsonFileURL)
    }

    /// Create a Drink.
    func createDrink(drink: Drink) {
        appendDrinkToJSON(drink: drink)
    }
    
    /// Retrieve a list with al Drinks.
    func readDrinks() -> [Drink] {
        guard let jsonData = try? Data(contentsOf: jsonFileURL) else {
            return []
        }
        return try! jsonDecoder.decode([Drink].self, from: jsonData)
    }
    
    /// Update a Drink.
    func updateDrink(drink: Drink) {
        var drinks = readDrinks()
        if let index = drinks.firstIndex(where: { $0.id == drink.id }) {
            drinks[index] = drink
        }
        let jsonData = try! jsonEncoder.encode(drinks)
        try! jsonData.write(to: jsonFileURL)
    }
    
    /// Remove a Drink from the JSON file.
    func deleteDrink(drink: Drink) {
        var drinks = readDrinks()
        if let index = drinks.firstIndex(where: { $0.id == drink.id }) {
            drinks.remove(at: index)
        }
        let jsonData = try! jsonEncoder.encode(drinks)
        try! jsonData.write(to: jsonFileURL)
    }
    
    /// Add o Remove a Drink from the Favorite List.
    func addOrRemoveFavorite(drink: Drink) {
        var drinks = readDrinks()
        if let index = drinks.firstIndex(where: { $0.id == drink.id }) {
            drinks[index].isFavorite.toggle()
        }
        let jsonData = try! jsonEncoder.encode(drinks)
        try! jsonData.write(to: jsonFileURL)
        self.updateCarouselElements()
    }
    
    /// Check if the file "drinks.json" exist and if it's empty.
    func checkJSONFile() -> Bool {
        let fileManager = FileManager.default
        let documentDirectory = try! fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let jsonFileURL = documentDirectory.appendingPathComponent("drinks.json")
        // check if file exist
        if !fileManager.fileExists(atPath: jsonFileURL.path) {
            return false
        }
        // check if file is empty
        if let fileSize = try? fileManager.attributesOfItem(atPath: jsonFileURL.path)[.size], fileSize as? Int == 0 {
            return false
        }
        return true
    }
    
    
}
