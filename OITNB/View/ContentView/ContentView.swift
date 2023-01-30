//
//  MainScreenView.swift
//  OITNB
//
//  Created by Fabrizio Chiariello on 11/01/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var vm: DrinkViewModel
    @AppStorage("bacValue") var bacValue : String = "0.000"
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                VStack(spacing: 50) {
                    BACView(bacImage: "exclamationmark.triangle.fill", bacDescription: "Warning!")
                    BasicDrinksView()
                    HStack {
                        Text("My Drinks")
                            .font(.title2)
                            .fontWeight(.semibold)
                        Spacer()
                        NavigationLink(destination: {
                            DrinksListView()
                        }, label: {
                            Text("Full List")
                                .foregroundColor(Color("MainColor"))
                        })
                    }
                    if vm.carouselElements.isEmpty {
                        NavigationLink(destination: {DrinksListView()}, label: {
                            emptyFavoritesView
                        })
                    } else {
                        Carousel(pageWidth: geo.size.width/2)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing, content: {
                        NavigationLink(destination: {
                            AccountView()
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
            
        }
        .onAppear{
            bacValue = "0.000"
        }
    }
    /// The view that shows when the favorites carousel is empty
    private var emptyFavoritesView: some View {
        return ZStack {
            Circle()
                .foregroundColor(Color("MainColor"))
            VStack {
                Text("Add your\nfavorites drinks")
                    .padding()
                Image(systemName: "plus")
                    .bold()
                    .font(.system(size: 30))
            }
            .foregroundColor(colorScheme == .dark ? Color.black : Color.white)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


