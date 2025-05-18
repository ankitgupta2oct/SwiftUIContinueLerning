//

import SwiftUI

struct ScrollViewPaggingScreen: View {
  @State var randomId: Int? = 0
  
    var body: some View {
      
      // MARK: Horizontial Scroll
      
      VStack {
        Button("Random Jump") {
          randomId = Int.random(in: 0..<20)
        }
        
        ScrollView(.horizontal) {
          HStack(spacing: 0) {
            ForEach(0..<20) { index in
              Rectangle()
                .fill(index % 2 == 0 ? .red : .green)
                .frame(height: 300)
                .id(index)
                .overlay {
                  Text("\(index)")
                    .bold()
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                }
                .padding()
                .containerRelativeFrame(.horizontal, alignment: .center)
                .scrollTransition { content, phase in
                  content
                    .opacity(phase.isIdentity ? 1 : 0)
                    .offset(y: phase.isIdentity ? 0 : -100)
                }
            }
          }
        }
        .scrollPosition(id: $randomId, anchor: .center)
        .scrollTargetLayout()
        .scrollTargetBehavior(.paging)
        .scrollIndicators(.hidden)
        .animation(.smooth(duration: 1), value: randomId)
      }
      
      
      // MARK: TicTok UI
      
//      ScrollView {
//        VStack(spacing: 0) {
//          ForEach(0..<10) { index in
//            Rectangle()
//              .fill(index % 2 == 0 ? .red : .green)
//              .overlay {
//                Text("\(index)")
//                  .bold()
//                  .font(.largeTitle)
//                  .foregroundStyle(.white)
//              }
//              .containerRelativeFrame(.vertical, alignment: .center)
//          }
//        }
//      }
//      .ignoresSafeArea()
//      .scrollTargetLayout()
////      .scrollTargetBehavior(.viewAligned)
//      .scrollTargetBehavior(.paging)
//      .scrollIndicators(.hidden)
//      .scrollBounceBehavior(.basedOnSize)
    }
}

#Preview {
    ScrollViewPaggingScreen()
}
