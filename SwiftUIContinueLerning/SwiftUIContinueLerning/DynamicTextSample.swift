//

import SwiftUI

struct DynamicTextSample: View {
    var body: some View {
      List {
        ForEach(0..<10) { _ in
          VStack(alignment: .leading) {
            HStack {
              Image(systemName: "heart.fill")
              Text("Hello, I love swiftUI")
                .bold()
            }
            Text("Hello all, I am learing SwiftUI. I find SwiftUI easy to learn framework.")
              .lineLimit(4)
              .minimumScaleFactor(0.8)
          }
        }
      }
    }
}

#Preview {
    DynamicTextSample()
}
