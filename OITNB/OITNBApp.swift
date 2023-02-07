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

    var body: some Scene {
        
        
        
        WindowGroup {
            let drinkViewModel = DrinkViewModel()
            if needsAppOnBoarding{
                OnBoardingView().environmentObject(drinkViewModel)
                    .task {
                        if !drinkViewModel.checkJSONFile() {
                            drinkViewModel.decodeLocalJSON()
                        }
                    }
                    .onAppear {
                        drinkViewModel.allDrinks = drinkViewModel.readDrinks()
                    }
            } else {
                ContentView().environmentObject(drinkViewModel)
                    .onAppear {
                        drinkViewModel.allDrinks = drinkViewModel.readDrinks()
                        drinkViewModel.timeUpdate()
                        print(drinkViewModel.lastDrinkDate)
                    }
                   
            }
        }
    }
}
