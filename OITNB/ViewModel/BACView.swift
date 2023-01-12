//
//  BACView.swift
//  OITNB
//
//  Created by Andrea Masturzo on 12/01/23.
//

import SwiftUI

struct BACView: View {
    
    var bacImage: String
    @AppStorage("bacValue") var bacValue : String = "0.000"
//    @State var bacLevel: String
    var bacDescription: String
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: bacImage)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.red)
                Text(bacDescription)
            }
            LiverLiquidView()
                .frame(width: 100, height: 100)
            Text("BAC: \(bacValue)(g/ml)")
        }
    }
}

//struct BACView_Previews: PreviewProvider {
//    static var previews: some View {
//        BACView()
//    }
//}
