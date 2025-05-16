//

import SwiftUI

struct HashableScreen: View {
  let items: [Item] = [
    Item(title: "One"),
    Item(title: "Two"),
    Item(title: "Three")
  ]
    var body: some View {
      List {
        ForEach(items, id: \.self) { item in
          Text(item.hashValue.description)
            .font(.title)
        }
      }
    }
}

struct Item: Hashable {
  let title: String
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(title)
  }
}

#Preview {
    HashableScreen()
}
