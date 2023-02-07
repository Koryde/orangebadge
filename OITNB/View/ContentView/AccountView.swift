//
//  AccountView.swift
//  OITNB
//
//  Created by Roberto D'Anna on 19/01/23.
//

import SwiftUI

struct AccountView: View {
    @State var gender = ["Male", "Female", "Prefer not to say"]
    @State var selectedGender = "Male"
    @State var weight = Array(stride(from: 35, to: 200, by: 1))
    @State var selectedWeight = 65
    @State private var isEditing = false
    @EnvironmentObject var drinkViewModel : DrinkViewModel
    
    
    var body: some View {
        //        NavigationView{
        Form{
            Section(header: Text("My info")){
                if isEditing {
                    VStack{
                        HStack{
                            
                            Picker("Gender", selection: $selectedGender) {
                                ForEach(gender, id: \.self) { _gender in
                                    Text("\(_gender)")
                                }
                            }
                        }
                        Divider()
                        HStack{
                            
                            Picker("Weight", selection: $selectedWeight) {
                                ForEach(weight, id: \.self) { _weight in
                                    Text("\(_weight)")
                                }
                            }
                        }
                        
                    }
                    
                }
                else {
                    VStack{
                        Spacer()
                        HStack{
                            Text("Gender")
                            Spacer()
                            Text("\(selectedGender)")
                        }
                        Spacer()
                        Divider()
                        Spacer()
                        HStack{
                            Text("Weight")
                            Spacer()
                            Text("\(selectedWeight)")
                        }
                        Spacer()
                    }
                    
                    
                }
            }
        }
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing, content: {
                Button {
                    if isEditing {
                        drinkViewModel.myGender = selectedGender
                        drinkViewModel.myWeight = Double(selectedWeight)
                    }
                    isEditing.toggle()
                    
                } label: {
                    if isEditing {
                        Text("Save")
                    } else{
                        Text("Edit")
                    }
                }
                
            })
        }
        
        
        //        }
        .onAppear {
            selectedWeight = Int(drinkViewModel.myWeight)
            selectedGender = drinkViewModel.myGender
        }
    }
    
    struct AccountView_Previews: PreviewProvider {
        static var previews: some View {
            AccountView()
        }
    }
}
