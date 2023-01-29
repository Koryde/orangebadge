//
//  OnBoarding.swift
//  OITNB
//
//  Created by Andrea Masturzo on 12/01/23.
//

import SwiftUI

struct OnBoardingView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @AppStorage ("location") private var location : String = ""
    @AppStorage("needsAppOnBoarding") private var needsAppOnBoarding: Bool = true
    @AppStorage("myGender") var myGender : String = ""
    @AppStorage("myWeight") var myWeight : Double = 0.0
    @State var isAnimating: Bool = false
    @State var gender = ["Male", "Female", "Prefer not to say"]
    @State var selectedGender = "Male"
    @State var weight = Array(stride(from: 35, to: 200, by: 1))
    @State var selectedWeight = 65
    
    var body: some View {
        ZStack {
            Color("MainColor")
                .opacity(0.8)
            VStack {
                Spacer()
                HStack {
                    Text("Welcome to <APP NAME>")
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .colorInvert()
                    
                }.padding()
                colorScheme == .light ?
                Image("OnBoarding")
                    .padding()
                : Image ("OnBoardingBlack")
                    .padding()
                HStack{
                    Text("Select your gender")
                        .font(.title)
                        .fontWeight(.medium)
                        .colorInvert()
                    Picker("Gender", selection: $selectedGender) {
                        ForEach(gender, id: \.self) { _gender in
                            Text("\(_gender)")
                        }
                        
                    }.scaleEffect(1.35)
                    
                        .accentColor(Color("MainInvertColor"))
                }
                .padding()
                HStack{
                    Text("Select your weight")
                        .font(.title)
                        .fontWeight(.medium)
                        .colorInvert()
                    
                    Picker("Weight", selection: $selectedWeight){
                        ForEach(weight, id: \.self) { _weight in
                            Text("\(_weight)")
                            
                        }
                    }
                    .scaleEffect(1.35)
                    .accentColor(Color("MainInvertColor"))
                    Text("Kg")
                        .font(.title)
                        .fontWeight(.medium)
                        .colorInvert()
                    
                }
                Spacer()
                
                Button(action: {
                    needsAppOnBoarding.toggle()
                    myGender = selectedGender
                    myWeight = Double(selectedWeight)
                    
                }, label: {
                    Text("Get Drunk")
                        .font(.headline)
                        .foregroundColor(Color("InvertText"))
                        .padding(.horizontal, 50)
                        .padding(.vertical, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(
                                    Color("MainInvertColor")
                                )
                        )
                })
                .shadow(radius:10)
                .padding()
            }
            
            .padding()
        }
        
        .onAppear(perform: {
            isAnimating = false
            withAnimation(.easeOut(duration: 0.5)) {
                self.isAnimating = true
            }
            let locale = Locale.current
            self.location = locale.language.region!.identifier
        })
        .ignoresSafeArea()
    }
}

struct OnBoarding_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
