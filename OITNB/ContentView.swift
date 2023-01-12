//
//  ContentView.swift
//  OITNB
//
//  Created by Roberto D'Anna on 11/01/23.
//

import SwiftUI

struct ContentView: View {
    @State var bac : String = ""
    
    private let drinks = [Circle(), Circle(), Circle(), Circle(), Circle()]
    
    @EnvironmentObject var appData : AppData
    var body: some View {
        MainScreenView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
