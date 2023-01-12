//
//  BasicDrinksView.swift
//  OITNB
//
//  Created by Fabrizio Chiariello on 11/01/23.
//

import SwiftUI


struct BasicDrinksView: View {
    
    private var basicDrinks = [Drink(category: Category.shot, name: "Shot", alcoholByVolume: 0.0, milliliters: 0.0, iconName: "DrinkingGlass"), Drink(category: Category.wine, name: "Wine", alcoholByVolume: 0.0, milliliters: 0.0, iconName: "WineGlass"), Drink(category: Category.beer, name: "Beer", alcoholByVolume: 0.0, milliliters: 0.0, iconName: "BeerGlass"), Drink(category: Category.midCocktail, name: "Cocktail", alcoholByVolume: 0.0, milliliters: 0.0, iconName: "CocktailGlass")]
    
    
    var body: some View {
        VStack {
            HStack(spacing: 15.0) {
                ForEach(basicDrinks, id: \.self) { drink in
                    BasicDrinkButton(drinkIcon: drink.iconName, drinkText: drink.name)
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
    
    var drinkIcon: String
    var drinkText: String
    
    var body: some View {
        Button(action: {}, label: {
            VStack {
                ZStack {
                    CircleView()
                        .frame(width:80, height: 80)
                    Image(drinkIcon)
                }
                Text(drinkText)
                    .foregroundColor(.black)
            }
        })
    }
}
