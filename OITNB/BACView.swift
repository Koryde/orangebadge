//
//  BACView.swift
//  OITNB
//
//  Created by Andrea Masturzo on 12/01/23.
//

import SwiftUI

struct BACView: View {
    
    var bacImage: String
    var bacLevel: String
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
            Text("BAC: \(bacLevel)")
        }
    }
}

//struct BACView_Previews: PreviewProvider {
//    static var previews: some View {
//        BACView()
//    }
//}
