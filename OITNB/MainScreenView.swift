//
//  MainScreenView.swift
//  OITNB
//
//  Created by Fabrizio Chiariello on 11/01/23.
//

import SwiftUI

struct MainScreenView: View {
    
    @EnvironmentObject var appData : AppData
    private let drinks = [Circle(), Circle(), Circle(), Circle(), Circle()]
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                VStack(spacing: 50) {
                    BACView(bacImage: "exclamationmark.triangle.fill", bacLevel: "0.000", bacDescription: "Warning!")
                    BasicDrinksView()
                    HStack {
                        Text("My Drinks")
                            .bold()
                        Spacer()
                        Button(action: {}, label: {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(Color("MainColor"))
                        })
                    }
                    Carousel(pageWidth: geo.size.width/2, content: drinks)
                }
            .padding()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "person.circle.fill")
                            .foregroundColor(Color("MainColor"))
                    })
                })
        }
        }
    }
}

struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
    }
}


