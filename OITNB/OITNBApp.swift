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
    @StateObject var drinkViewModel = DrinkViewModel()

    var body: some Scene {
        
        
        
        WindowGroup {
            if needsAppOnBoarding{
                OnBoardingView()
            } else {
                ContentView().environmentObject(drinkViewModel)
                    .task {
                        await drinkViewModel.getDrink()
                    }
            }
            
        }
    }
}
