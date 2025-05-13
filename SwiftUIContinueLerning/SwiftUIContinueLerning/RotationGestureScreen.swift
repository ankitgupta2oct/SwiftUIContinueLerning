//
//  RotationGestureScreen.swift
//  SwiftUIContinueLerning
//
//  Created by z0042k3y on 12/05/25.
//

import SwiftUI

struct RotationGestureScreen: View {
  @State private var rotationAngle: Angle = .zero
    var body: some View {
      Circle()
        .fill(.white)
        .frame(maxWidth: 200)
        .shadow(radius: 10)
        .overlay(alignment: .top) {
          Image(systemName: "arrowshape.up")
        }
        .rotationEffect(rotationAngle)
        .animation(.spring(), value: rotationAngle)
        .gesture(
          RotateGesture()
            .onChanged { value in
              rotationAngle = value.rotation
            }
            .onEnded { value in
              rotationAngle = .zero
            }
        )
    }
}

#Preview {
    RotationGestureScreen()
}
