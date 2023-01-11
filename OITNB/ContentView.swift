//
//  ContentView.swift
//  OITNB
//
//  Created by Roberto D'Anna on 11/01/23.
//

import SwiftUI

struct ContentView: View {
    @State var bac : String = ""
    @EnvironmentObject var appData : AppData
    var body: some View {
        VStack {
            Text("BAC")
                .fontWeight(.bold)
                .font(.system(size: 32))
            Text(bac.prefix(5))
        }.onAppear{
            bac = String(appData.calculateBac(drink: Drink(category: .shot, name: "Negroni", alcoholByVolume: 24, milliliters: 90.0, iconName: ""), myWeight: 80, myGender: "Male", haveEat: true))
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
