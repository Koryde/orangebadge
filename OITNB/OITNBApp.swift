//
//  OITNBApp.swift
//  OITNB
//
//  Created by Roberto D'Anna on 11/01/23.
//

import SwiftUI

@main
struct OITNBApp: App {
    @State private var appSetupState = "App not setup"
    @AppStorage ("needsAppOnBoarding") private var needsAppOnBoarding: Bool = true
    var body: some Scene {
        WindowGroup {
            let appData = AppData()
            
            if needsAppOnBoarding{
                OnBoardingView()
            } else {
                ContentView().environmentObject(appData)
            }
            
            
        }
    }
}
