//
//  GeometryReaderScreen.swift
//  SwiftUIContinueLerning
//
//  Created by z0042k3y on 14/05/25.
//

import SwiftUI

struct GeometryReaderScreen: View {
    var body: some View {
      ScrollView(.horizontal) {
        HStack {
          ForEach(0..<10) { _ in
            GeometryReader { geometry in
              RoundedRectangle(cornerRadius: 10)
                .rotation3DEffect(.degrees(getPercentage(geo: geometry)), axis: (x: 0.0, y: 1.0, z: 0.0))
            }
            .frame(minWidth: 300, maxHeight: 200)
            .padding()
          }
        }
      }
      .scrollIndicators(.hidden)
    }
  
  private func getPercentage(geo: GeometryProxy) -> Double {
    let maxDistance = getWidth() / 2
    let currentXPosition = geo.frame(in: .global).midX
    return (1 - (currentXPosition / maxDistance)) * 30
  }
  
  func getWidth() -> CGFloat {
    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
      return windowScene.screen.bounds.width
    }
    return .zero
  }
}

#Preview {
    GeometryReaderScreen()
}
