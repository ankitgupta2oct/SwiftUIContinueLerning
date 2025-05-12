//
//  LongPressGestureScreen.swift
//  SwiftUIContinueLerning
//
//  Created by z0042k3y on 12/05/25.
//

import SwiftUI

struct LongPressGestureScreen: View {
  @State private var isSussessful: Bool = false
  @State private var isComplete: Bool = false
  
    var body: some View {
      VStack(spacing: 20) {
        RoundedRectangle(cornerRadius: 10)
          .fill(isSussessful ? .green : .red )
          .frame(maxWidth: isComplete ? .infinity : 0)
          .frame(height: 50)
          .frame(maxWidth: .infinity, alignment: .leading)
          .background(.gray)
        
        Circle()
          .fill(.green)
          .frame(width: 100, height: 100)
          .overlay {
            Text(isSussessful ? "Reset" : "Tap")
              .font(.largeTitle)
              .bold()
          }
          .onLongPressGesture(minimumDuration: 1) {
            if(isSussessful) {
              isSussessful = false
              isComplete = false
              return
            }
              withAnimation(.easeInOut(duration: 1)) {
                isSussessful = true
              }
            } onPressingChanged: { inProgress in
              if(inProgress) {
                withAnimation(.easeInOut(duration: 1)) {
                  isComplete = true
                }
              }
              else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                  if(!isSussessful) {
                    withAnimation(.easeInOut(duration: 1)) {
                      isComplete = false
                    }
                  }
                }
              }
            }
      }
    }
}

#Preview {
    LongPressGestureScreen()
}
