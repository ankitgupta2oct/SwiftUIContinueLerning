//

import SwiftUI

struct AlignmentGuideScreen: View {
  let items: [Item] = [
      Item(text: "One", isIconVisible: true),
      Item(text: "Two", isIconVisible: false),
      Item(text: "Three", isIconVisible: true),
  ]

  var body: some View {
    VStack(alignment: .leading) {
      ForEach(items, id: \.text) { item in
        HStack {
          if(item.isIconVisible) {
            Image(systemName: "checkmark")
          }
          Text(item.text)
        }
        .alignmentGuide(.leading) { dimension in
          return item.isIconVisible ? 30 : 0
        }
      }
    }
    .padding()
    .background(.white)
    .clipShape(.rect(cornerRadius: 10))
    .shadow(radius: 10)
  }
  
  struct Item {
    let text: String
    let isIconVisible: Bool
  }
}

#Preview {
    AlignmentGuideScreen()
}
