//
//  MagnificationGestureScreen.swift
//  SwiftUIContinueLerning
//
//  Created by z0042k3y on 12/05/25.
//

import SwiftUI

struct MagnificationGestureScreen: View {
  @State private var scaleValue: CGFloat = 0
  
    var body: some View {
      Image("forg")
        .resizable()
        .frame(maxWidth: 200, maxHeight: 150)
        .scaledToFit()
        .scaleEffect(scaleValue + 1)
        .animation(.spring(), value: scaleValue)
        .gesture(
          MagnifyGesture()
            .onChanged { value in
              scaleValue = value.magnification - 1
            }
            .onEnded { value in
              scaleValue = 0
            })
    }
}

#Preview {
    MagnificationGestureScreen()
}
