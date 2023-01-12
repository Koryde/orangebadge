//
//  OnBoarding.swift
//  OITNB
//
//  Created by Andrea Masturzo on 12/01/23.
//

import SwiftUI
///
struct OnBoardingView: View {
    @State var gender = ["Male", "Female", "Prefer not to say"]
    @State var selectedGender = "Male"
    @State var weight = Array(stride(from: 30, to: 350, by: 1))
    @State var selectedWeight = 45
    
    var body: some View {
        ZStack {
            Color("MainColor")
                .opacity(0.8)
            VStack {
                HStack {
                    Text("Welcome to <APP NAME>")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .colorInvert()
                        
                }.padding()
                    Image("CocktailGlass")
                    .resizable()
                    .frame(width: 150,height: 150)
                    .padding()
                HStack{
                    Text("Select your gender")
                        .font(.title3)
                        .fontWeight(.medium)
                        .colorInvert()
                    Picker("Gender", selection: $selectedGender) {
                        ForEach(gender, id: \.self) { _gender in
                            Text("\(_gender)")
                                
                        }
                    }
                }
                .padding()
                HStack{
                    Text("Select your weight")
                        .font(.title3)
                        .fontWeight(.medium)
                        .colorInvert()
                    
                    Picker("Weight", selection: $selectedWeight){
                        ForEach(weight, id: \.self) { _weight in
                            Text("\(_weight)")
                        }
                    }
                    Text("Kg")
                        .font(.title3)
                        .fontWeight(.medium)
                        .colorInvert()
                    
                }
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    Button(action: {
                        
                    }, label: {
                        Text("Save")
                            .foregroundColor(Color("MainColor"))
                    })
                })
        }
        }
        .ignoresSafeArea()
    }
}

struct OnBoarding_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
