import SwiftUI

@Observable
final class MultiThreadScreenViewModel {
  var items: [String] = []
  
  func fetchItems() {
    DispatchQueue.global(qos: .background).async { [weak self] in
      if let downloadedItems = self?.downloadData() {
        DispatchQueue.main.async {
          self?.items.append(contentsOf: downloadedItems)
        }
      }
    }
  }
  
  private func downloadData() -> [String] {
    var tempData: [String] = []
    
    for x in 1..<100 {
      tempData.append("\(items.count + x)")
    }
    
    return tempData
  }
}

struct MultiThreadScreen: View {
  @State var vm = MultiThreadScreenViewModel()
    var body: some View {
      VStack {
        Button("Fetch Data") {
          vm.fetchItems()
        }
        .buttonStyle(.borderedProminent)
        
        List {
          ForEach(vm.items, id: \.self) { item in
            Text("\(item)")
          }
          .listStyle(.plain)
        }
      }
    }
}

#Preview {
    MultiThreadScreen()
}
