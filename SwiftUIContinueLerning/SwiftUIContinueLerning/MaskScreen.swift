//
//  MaskSCreen.swift
//  SwiftUIContinueLerning
//
//  Created by z0042k3y on 14/05/25.
//

import SwiftUI

struct MaskScreen: View {
  @State private var rating: Int = 1
  
  var body: some View {
    starView
      .overlay(overlayView.mask(starView))
  }
  
  private var overlayView: some View {
    GeometryReader {geomatry in
     Rectangle()
       .fill(
         LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading, endPoint: .trailing)
       )
       .frame(width: (CGFloat(rating) / 5) * geomatry.size.width)
    }
    .allowsHitTesting(false)
  }
  
  private var starView: some View {
    HStack {
      ForEach(1..<6) { index in
        Image(systemName: rating >= index ? "star.fill" : "star")
          .font(.largeTitle)
          .onTapGesture {
            rating = index
          }
          .animation(.easeIn(duration: 0.2), value: rating)
      }
    }
  }
}

#Preview {
    MaskScreen()
}
