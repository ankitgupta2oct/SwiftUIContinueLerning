//
//  ScrollViewReaderScreen.swift
//  SwiftUIContinueLerning
//
//  Created by z0042k3y on 13/05/25.
//

import SwiftUI

struct ScrollViewReaderScreen: View {
  @State private var pageNumber: Int = 0
  
    var body: some View {
      VStack {
        TextField("Enter the page number", text: Binding<String>(
          get: {
            String(pageNumber)
          },
          set: { newValue in
            if let newValue = Int(newValue) {
              pageNumber = newValue
            } else {
              pageNumber = 0
            }
          }
        ))
        .padding()
        .background(.gray)
        .padding()
        
        Text("Page \(pageNumber)")
          .font(.headline)
          .padding()
        
        ScrollView {
          ScrollViewReader { proxy in
            ForEach(1..<100) { index in
              RoundedRectangle(cornerRadius: 10)
                .frame(maxWidth: .infinity, minHeight: 100)
                .padding()
                .id(index)
                .overlay {
                  Text("Page \(index)")
                    .font(.title3)
                    .foregroundStyle(.white)
                    .bold()
                }
            }
            .onChange(of: pageNumber) {
              withAnimation(.spring) {
                proxy.scrollTo(pageNumber, anchor: .center)
              }
            }
          }
        }
      }
    }
}

#Preview {
    ScrollViewReaderScreen()
}
