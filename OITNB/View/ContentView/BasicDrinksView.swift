//
//  BasicDrinksView.swift
//  OITNB
//
//  Created by Fabrizio Chiariello on 11/01/23.
//

import SwiftUI


struct BasicDrinksView: View {
    
//    @EnvironmentObject var drinkViewModel : DrinkViewModel

    private var basicDrinks = [Drink(category: Category.shot, name: "Shot", alcoholByVolume: 43.15, milliliters: 30.0, isFavorite: false), Drink(category: Category.wine, name: "Wine", alcoholByVolume: 13.5, milliliters: 175.0, isFavorite: false), Drink(category: Category.beer, name: "Beer", alcoholByVolume: 7.5, milliliters: 375.0, isFavorite: false), Drink(category: Category.shortDrink, name: "Cocktail", alcoholByVolume: 28.56, milliliters: 80.6, isFavorite: false)]
    
    
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
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var drinkViewModel : DrinkViewModel
    
    var drink : Drink
    
    var body: some View {
        Button(action: {
            drinkViewModel.bacValue = String(String(drinkViewModel.calculateBac(drink: drink, myWeight: drinkViewModel.myWeight, myGender: drinkViewModel.myGender, haveEat: drinkViewModel.haveEat, bacValue: drinkViewModel.bacValue, drankListOpen: false)).prefix(5))
            drinkViewModel.addDrinkToDrank(drink: drink)
            
        }, label: {
            VStack {
                ZStack {
                    CircleView()
                        .frame(width:80, height: 80)
                    colorScheme == .light ?
                    Image(drink.category.iconName)
                    :
                    Image(drink.category.iconNameBlack)
                }
                Text(drink.name)
                    .foregroundColor(Color("RightText"))
            }
        })
    }
}
