//
//  MainScreenView.swift
//  OITNB
//
//  Created by Fabrizio Chiariello on 11/01/23.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var drinkViewModel : DrinkViewModel
    @AppStorage("bacValue") var bacValue : String = "0.000"
    private let drinks = [Circle(), Circle(), Circle(), Circle(), Circle()]
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                VStack(spacing: 50) {
                    BACView(bacImage: "exclamationmark.triangle.fill", bacDescription: "Warning!")
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
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing, content: {
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: "person.circle.fill")
                                .foregroundColor(Color("MainColor"))
                        })
                        .transaction { transaction in
                            transaction.animation = nil
                        }
                    })
                }
                .padding()
                
            }
            
        }.onAppear{
            bacValue = "0.000"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


