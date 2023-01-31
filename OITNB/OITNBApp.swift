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
            } else {
                ContentView().environmentObject(drinkViewModel)
                    .task {
                        if !drinkViewModel.checkJSONFile() {
                            drinkViewModel.decodeLocalJSON()
                        }
                    }
            }
            
        }
    }
}
