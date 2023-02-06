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
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("My info")){
                    VStack{
                        Picker("Gender", selection: $selectedGender) {
                            ForEach(gender, id: \.self) { _gender in
                                Text("\(_gender)")
                            }
                            
                        }
                        Picker("Weight", selection: $selectedWeight){
                            ForEach(weight, id: \.self) { _weight in
                                Text("\(_weight)")
                                
                            }
                        }
                    }
                }
            }
            
        }
    }
    
    struct AccountView_Previews: PreviewProvider {
        static var previews: some View {
            AccountView()
        }
    }
}
