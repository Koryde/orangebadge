//
//  OITNBApp.swift
//  OITNB
//
//  Created by Roberto D'Anna on 11/01/23.
//

import SwiftUI

@main
struct OITNBApp: App {
    
    @AppStorage ("needsAppOnBoarding") private var needsAppOnBoarding: Bool = true
//    @StateObject var drinkViewModel = DrinkViewModel()

    var body: some Scene {
        
        
        
        WindowGroup {
            let drinkViewModel = DrinkViewModel()
            if needsAppOnBoarding{
                OnBoardingView().environmentObject(drinkViewModel)
                    .onAppear {
                        drinkViewModel.allDrinks = drinkViewModel.readDrinks()
                    }
            } else {
                ContentView().environmentObject(drinkViewModel)
                    .onAppear {
                        drinkViewModel.allDrinks = drinkViewModel.readDrinks()
                        print(drinkViewModel.lastDrinkDate)
                    }
                    .task {
                        if !drinkViewModel.checkJSONFile() {
                            drinkViewModel.decodeLocalJSON()
                        }
                    }
            }
        }
    }
}
