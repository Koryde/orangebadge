//
//  MainScreenView.swift
//  OITNB
//
//  Created by Fabrizio Chiariello on 11/01/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var drinkViewModel : DrinkViewModel
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                VStack(spacing: 50) {
                    BACView()
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
                    if drinkViewModel.carouselElements.isEmpty {
                        NavigationLink(destination: {DrinksListView()}, label: {
                            emptyFavoritesView
                        })
                    } else {
                        Carousel(pageWidth: geo.size.width/2)
                    }
                }
                .alert("Have you eaten in the last two hours?", isPresented: $drinkViewModel.haveEatToggle) {
                    Button {
                        drinkViewModel.haveEat = true
                        drinkViewModel.canCalculateBac = true
                        drinkViewModel.haveEatToggle.toggle()
                    } label: {
                        Text("Yes")
                    }
                    Button {
                        drinkViewModel.haveEat = false
                        drinkViewModel.canCalculateBac = true
                        drinkViewModel.haveEatToggle.toggle()
                    } label: {
                        Text("No")
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
           drinkViewModel.bacValue = "0.000"
        }
    }
    /// The view that shows when the favorites carousel is empty
    private var emptyFavoritesView: some View {
        return ZStack {
            Circle()
                .foregroundColor(Color("MainColor"))
            VStack {
                Text("Add your\nfavorite drinks")
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


