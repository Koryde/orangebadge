//
//  BasicDrinksView.swift
//  OITNB
//
//  Created by Fabrizio Chiariello on 11/01/23.
//

import SwiftUI


struct BasicDrinksView: View {
    @EnvironmentObject var appData : AppData

    private var basicDrinks = [Drink(category: Category.shot, name: "Shot", alcoholByVolume: 30.0, milliliters: 40.0, iconName: "DrinkingGlass"), Drink(category: Category.wine, name: "Wine", alcoholByVolume: 13.0, milliliters: 125.0, iconName: "WineGlass"), Drink(category: Category.beer, name: "Beer", alcoholByVolume: 5.0, milliliters: 330.0, iconName: "BeerGlass"), Drink(category: Category.midCocktail, name: "Cocktail", alcoholByVolume: 19.0, milliliters: 100.0, iconName: "CocktailGlass")]
    
    
    var body: some View {
        VStack {
            HStack(spacing: 15.0) {
                ForEach(basicDrinks, id: \.self) { drink in
                    BasicDrinkButton(drink: drink)
                }
            }
        }
    }
    
    struct BasicDrinksView_Previews: PreviewProvider {
        static var previews: some View {
            BasicDrinksView()
        }
    }
}

struct CircleView: View {
    var body: some View {
        Circle()
            .fill(Color("MainColor"))
    }
}

struct BasicDrinkButton: View {
    
    @EnvironmentObject var appData : AppData
    @AppStorage("bacValue") var bacValue : String = "0.000"
    var drink : Drink
    
    var body: some View {
        Button(action: {
            bacValue = String(String(appData.calculateBac(drink: drink, myWeight: 80, myGender: "Male", haveEat: true, bacValue: bacValue)).prefix(5))
        }, label: {
            VStack {
                ZStack {
                    CircleView()
                        .frame(width:80, height: 80)
                    Image(drink.iconName)
                }
                Text(drink.name)
                    .foregroundColor(.black)
            }
        })
    }
}
