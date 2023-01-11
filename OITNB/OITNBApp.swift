//
//  OITNBApp.swift
//  OITNB
//
//  Created by Roberto D'Anna on 11/01/23.
//

import SwiftUI

@main
struct OITNBApp: App {
    var body: some Scene {
        WindowGroup {
            let appData = AppData()
            ContentView().environmentObject(appData)
        }
    }
}
