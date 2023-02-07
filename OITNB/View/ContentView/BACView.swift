//
//  BACView.swift
//  OITNB
//
//  Created by Andrea Masturzo on 12/01/23.
//

import SwiftUI

struct BACView: View {
    
    @EnvironmentObject var drinkViewModel : DrinkViewModel
    @State private var showDrankList: Bool = false
    @State private var actualBacLevel : Float = 0
    
    var body: some View {
        VStack {
            changingBacHeader
            LiverLiquidView()
                .onTapGesture {
                    self.showDrankList.toggle()
                }
                .sheet(isPresented: $showDrankList, content: {
                    DrankListView()
                })
                .frame(width: 100, height: 100)
            Text("BAC: ") + Text(String(format: "%.3f", actualBacLevel)) + Text(" g/l")
        }
        .onChange(of: drinkViewModel.bacValue) { bac in
            actualBacLevel = Float(drinkViewModel.bacValue)!
            print(actualBacLevel)
        }
        .onAppear {
            actualBacLevel = Float(drinkViewModel.bacValue)!
        }
    }
    
    private var changingBacHeader: some View {
        let floatBac = Float(drinkViewModel.bacValue)
        return Group {
            if floatBac! < 0.500 {
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.green)
                    Text("You're good!")
                }
            } else if floatBac! < 1.200 {
                HStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.yellow)
                    Text("Don't drive!")
                }
            } else if floatBac! < 3.000 {
                HStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.red)
                    Text("It's getting dangerous!")
                }
            } else if floatBac! > 3.001 {
                HStack {
                    Image("skull")
                        .resizable()
                        .frame(width: 100, height: 100)
                    VStack {
                        Text("Man, you're probably")
                        Text("dead already. GG.")
                    }
                }
            }
        }
    }
}
    

//struct BACView_Previews: PreviewProvider {
//    static var previews: some View {
//        BACView()
//    }
//}
