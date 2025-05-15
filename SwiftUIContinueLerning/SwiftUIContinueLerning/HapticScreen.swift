//
//  HapticScreen.swift
//  SwiftUIContinueLerning
//
//  Created by z0042k3y on 15/05/25.
//

import SwiftUI

struct HapticScreen: View {
    var body: some View {
      VStack(spacing: 40) {
        Button("Success Notification") {
          HapticManager.shared.notification(type: .success)
        }
        
        Button("Warning Notification") {
          HapticManager.shared.notification(type: .warning)
        }
        
        Button("Error Notification") {
          HapticManager.shared.notification(type: .error)
        }
        
        Divider()
        
        Button("Light Impact") {
          HapticManager.shared.impact(style: .light)
        }
        
        Button("Medium Impact") {
          HapticManager.shared.impact(style: .medium)
        }
        
        Button("Heavy Impact") {
          HapticManager.shared.impact(style: .heavy)
        }
        
        Button("Soft") {
          HapticManager.shared.impact(style: .soft)
        }
        
        Button("Rigid") {
          HapticManager.shared.impact(style: .rigid)
        }
      }
    }
}

final class HapticManager {
  private init () {}
  
  static let shared = HapticManager()

  func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
    UINotificationFeedbackGenerator().notificationOccurred(type)
  }
  
  func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
    let generator = UIImpactFeedbackGenerator(style: style)
    generator.impactOccurred()
  }
}

#Preview {
    HapticScreen()
}
