//
//  OnBoarding.swift
//  OITNB
//
//  Created by Andrea Masturzo on 12/01/23.
//

import SwiftUI

struct OnBoardingView: View {
    @State var gender = ["Male", "Female", "Prefer not to say"]
    @State var selectedGender = "Male"
    @State var weight = Array(stride(from: 30, to: 350, by: 1))
    @State var selectedWeight = 45
    
    var body: some View {
        VStack {
            HStack {
                Text("Welcome to <APP NAME>")
                Image(systemName: "wineglass.fill")
            }
            
            Picker("Gender", selection: $selectedGender) {
                ForEach(gender, id: \.self) { _gender in
                    Text("\(_gender)")
                }
            }
            .pickerStyle(.segmented)
            
            HStack {
                Picker("Weight", selection: $selectedWeight){
                    ForEach(weight, id: \.self) { _weight in
                        Text("\(_weight)")
                    }
                }
                .pickerStyle(.wheel)
                Text("Kg")
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
}

struct OnBoarding_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
