//
//  LiverLiquidView.swift
//  OITNB
//
//  Created by Raffaele Siciliano on 12/01/23.
//

import SwiftUI

struct LiverLiquidView: View {
    
    @AppStorage("bacValue") var bacValue : String = "0.000"
    @State var progress : CGFloat = 0.5
    @State var startAnimation : CGFloat = 0
    
    var body: some View {
        ZStack {
            VStack {
                GeometryReader{ proxy in
                    let size = proxy.size
                    
                    ZStack {
                        LiquidWave(progress: progress, waveHeight: 0.05, offset: startAnimation)
                            .fill(Color("MainColor"))
                            .mask {
                                Image("liver.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    
                            }.onChange(of: bacValue, perform: { value in
                                progress = CGFloat(Float(Float(bacValue)!/10)*2)
                            })
                        Image("liver")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.primary)
                        
                    }.frame(width: size.width, height: size.height, alignment: .center)
                        .onAppear{
                            // Looping Animation
                            withAnimation(.easeInOut(duration: 5).repeatForever(autoreverses: true)) {
                                startAnimation = size.width*2
                            }
                        }
                }.frame(height: 350)
            }
        }
    }
}

struct LiquidWave : Shape {
    
    var progress : CGFloat
    var waveHeight : CGFloat
    var offset : CGFloat
    var animatableData: CGFloat {
        get{offset}
        set{offset = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        return Path{ path in
            path.move(to: .zero)
            
            let progressHeight : CGFloat = (1 - progress) * rect.height
            let height = waveHeight * rect.height
            
            for value in stride(from: 0, to: rect.width, by: 2) {
                
                let x : CGFloat = value
                let sine : CGFloat = sin(Angle(degrees: value + offset).radians)
                let y : CGFloat = progressHeight + (height * sine)
                
                path.addLine(to: CGPoint(x: x, y: y))
            }
            
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            
        }
    }
}

struct LiverLiquidView_Previews: PreviewProvider {
    static var previews: some View {
        LiverLiquidView()
    }
}
