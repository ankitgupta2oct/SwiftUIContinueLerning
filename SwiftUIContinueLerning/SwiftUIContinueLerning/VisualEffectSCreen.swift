//

import SwiftUI

struct VisualEffectSCreen: View {
    var body: some View {
      ScrollView {
        VStack {
          ForEach(0..<100) { _ in
            Rectangle()
              .fill(.red)
              .overlay {
                Text("Hello")
                  .foregroundStyle(.white)
                  .bold()
              }
              .frame(maxWidth: .infinity, minHeight: 100)
              .visualEffect { content, geomtry in
                content
                  .offset(x: geomtry.frame(in: .global).midY * 0.5)
                  .grayscale(geomtry.frame(in: .global).minY / geomtry.frame(in: .global).maxY)   
              }
          }
        }
      }
    }
}

#Preview {
    VisualEffectSCreen()
}
