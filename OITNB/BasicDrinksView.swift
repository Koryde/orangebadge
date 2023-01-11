//
//  BasicDrinksView.swift
//  OITNB
//
//  Created by Fabrizio Chiariello on 11/01/23.
//

import SwiftUI

struct BasicDrinksView: View {
    var body: some View {
        VStack {
            
            //BASIC DRINKS
            HStack(spacing: 15.0) {
                
                ZStack {
                    CircleView()
                        .frame(width:80, height: 80)
                    Image("DrinkingGlass")
                }
                ZStack {
                    CircleView()
                        .frame(width:80, height: 80)
                    Image( "WineGlass")
                }
                ZStack {
                    CircleView()
                        .frame(width:80, height: 80)
                    Image("BeerGlass")
                }
                ZStack {
                    CircleView()
                        .frame(width:80, height: 80)
                    Image("CocktailGlass")
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
