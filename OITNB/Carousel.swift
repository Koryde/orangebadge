//
//  Carousel.swift
//  OITNB
//
//  Created by Andrea Masturzo on 11/01/23.
//

import SwiftUI

struct Carousel<Content: View>: View {
    let pageWidth: CGFloat
    let content: [Content]
    
    @State private var offset: CGFloat = 0
    @State private var index = 0
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center, spacing: 1) {
                ForEach(content.indices) { index in
                    self.content[index]
                        .frame(width: self.pageWidth, height: nil)
                }
            }
        }
        .content.offset(x: offset)
        .frame(width: pageWidth, height: nil, alignment: .leading)
        .gesture(
            DragGesture()
                .onChanged { value in
                    self.offset = value.translation.width - (CGFloat(self.index) * self.pageWidth)
                }
                .onEnded { value in
                    let newIndex = self.newIndex(-value.translation.width, currentIndex: self.index)
                    self.index = newIndex
                    withAnimation { self.offset = -(CGFloat(self.index) * self.pageWidth) }
                }
        )
    }
    // this allows the snapping of the element in the middle of the screen
    private func newIndex(_ translation: CGFloat, currentIndex: Int) -> Int {
        let snapDistance = pageWidth / 2
        // this allows going back to first item when last is reached
        let newIndex: Int
        if translation > -snapDistance {
            newIndex = currentIndex + 1 >= content.count ? 0 : currentIndex + 1
        } else if translation < snapDistance {
            newIndex = currentIndex - 1 < 0 ? content.count - 1 : currentIndex - 1
        } else {
            newIndex = currentIndex
        }
        return newIndex
    }
}


