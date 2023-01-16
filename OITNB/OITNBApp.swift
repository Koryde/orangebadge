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
        
        let drinkViewModel = DrinkViewModel()
        
        WindowGroup {
            if needsAppOnBoarding{
                OnBoardingView()
            } else {
                ContentView().environmentObject(drinkViewModel)
            }
            
        }
    }
}
