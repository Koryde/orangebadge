//
//  OnBoarding.swift
//  OITNB
//
//  Created by Roberto D'Anna on 11/01/23.
//

import SwiftUI

struct OnBoarding: View {
    var body: some View {
        ZStack{
            VStack{
                Text("Hello, drinker!")
                    .font(.largeTitle)
                    .fontWeight(.medium)
                    .colorInvert()
            }
        }
        .ignoresSafeArea()
    }
}

struct OnBoarding_Previews: PreviewProvider {
    static var previews: some View {
        OnBoarding()
    }
}
