//
//  BasicDrinksView.swift
//  OITNB
//
//  Created by Fabrizio Chiariello on 11/01/23.
//

import SwiftUI


struct BasicDrinksView: View {
    
//    @EnvironmentObject var drinkViewModel : DrinkViewModel

    private var basicDrinks = [Drink(category: Category.shot, name: "Shot", alcoholByVolume: 43.15, milliliters: 30.0), Drink(category: Category.wine, name: "Wine", alcoholByVolume: 13.5, milliliters: 175.0), Drink(category: Category.beer, name: "Beer", alcoholByVolume: 7.5, milliliters: 375.0), Drink(category: Category.shortDrink, name: "Cocktail", alcoholByVolume: 28.56, milliliters: 80.6)]
    
    
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
    
    @EnvironmentObject var drinkViewModel : DrinkViewModel
    @AppStorage("bacValue") var bacValue : String = "0.000"
    @AppStorage("myGender") var myGender : String = ""
    @AppStorage("myWeight") var myWeight : Double = 0.0
    var drink : Drink
    
    var body: some View {
        Button(action: {
            bacValue = String(String(drinkViewModel.calculateBac(drink: drink, myWeight: myWeight, myGender: myGender, haveEat: true, bacValue: bacValue)).prefix(5))
        }, label: {
            VStack {
                ZStack {
                    CircleView()
                        .frame(width:80, height: 80)
                    Image(drink.category.iconName)
                }
                Text(drink.name)
                    .foregroundColor(.black)
            }
        })
    }
}
