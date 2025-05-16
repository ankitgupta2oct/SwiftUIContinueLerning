//

import SwiftUI

@Observable
final class SortMapFilterScreenViewModel {
  private var originialItems: [ArrayItem] = [
    ArrayItem(title: "One", point: 11, isVerified: true),
    ArrayItem(title: "Two", point: 2, isVerified: false),
    ArrayItem(title: "Three", point: 33, isVerified: false),
    ArrayItem(title: "Four", point: 23, isVerified: false),
    ArrayItem(title: "Five", point: 15, isVerified: true),
    ArrayItem(title: "Six", point: 6, isVerified: true),
    ArrayItem(title: "Seven", point: 7, isVerified: true),
    ArrayItem(title: "Eight", point: 18, isVerified: false),
    ArrayItem(title: "Nine", point: 90, isVerified: true),
    ArrayItem(title: "Ten", point: 100, isVerified: false)
  ]
  
  private var modifiedItems: [ArrayItem] = []
  
  init() {
    // Sort
    modifiedItems = originialItems
      .filter { $0.isVerified || $0.point > 80 }
      .sorted { $0.point < $1.point }
      .compactMap{ $0 }
  }
  
  //Mark: - Public Methods
  func arrayItems() -> [ArrayItem] {
    return modifiedItems
  }
}

struct SortMapFilterScreen: View {
  @State var viewModel = SortMapFilterScreenViewModel()
  
  var body: some View {
    ScrollView {
      ForEach(viewModel.arrayItems()) { item in
        HStack {
          VStack(alignment: .leading) {
            Text(item.title)
              .font(.title)
            Text("Point: \(item.point)")
              .font(.subheadline)
          }
          Spacer()
          Image(systemName: "checkmark.seal.fill")
            .foregroundColor(item.isVerified ? .green : .red)
        }
        .padding()
        .background(.blue)
        .clipShape(.rect(cornerRadius: 10))
        .padding()
      }
    }
  }
}

struct ArrayItem: Identifiable {
  let id = UUID().uuidString
  let title: String
  let point: Int
  let isVerified: Bool
}

#Preview {
    SortMapFilterScreen()
}
