//
//  DragGestureScreen.swift
//  SwiftUIContinueLerning
//
//  Created by z0042k3y on 13/05/25.
//

import SwiftUI

struct DragGestureScreen: View {
  @State private var offset: CGSize = .zero
  
  var body: some View {
    VStack {
      Text("\(offset.width)")
      
      RoundedRectangle(cornerRadius: 20)
        .frame(maxWidth: 300, maxHeight: 500)
        .offset(offset)
        .scaleEffect(scaleAmount)
        .rotationEffect(.degrees(rotationAmount))
        .gesture(
          DragGesture()
            .onChanged { value in
              offset = value.translation
            }
            .onEnded { value in
              offset = .zero
            }
        )
    }
  }
  
  private var scaleAmount: CGFloat {
    let maxWidth = getWidth() / 2
    let currentAmount = abs(offset.width)
    let per = currentAmount / maxWidth
    return 1.0 - min(per, 0.5) * 0.5
  }
  
  private var rotationAmount: CGFloat {
    let maxWidth = getWidth() / 2
    let currentAmount = offset.width
    let per = currentAmount / maxWidth
    let maxAngle: Double = 10
    return maxAngle * per
  }
  
  func getWidth() -> CGFloat {
    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
      return windowScene.screen.bounds.width
    }
    return .zero
  }
}

#Preview {
    DragGestureScreen()
}
