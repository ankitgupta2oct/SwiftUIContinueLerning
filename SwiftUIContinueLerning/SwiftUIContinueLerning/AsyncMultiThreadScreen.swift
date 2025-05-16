import SwiftUI

@MainActor
@Observable
final class AsyncMultiThreadScreenViewModel {
  var items: [String] = []
  
  func fetchItems() async {
    Task.detached {
      let downloadedItems = await self.downloadData()
      await MainActor.run {
        self.items.append(contentsOf: downloadedItems)
      }
    }
  }
  
  private func downloadData() async -> [String]  {
    try? await Task.sleep(for: .seconds(2))
    
    var tempData: [String] = []
    for x in 1..<100 {
      tempData.append("\(items.count + x)")
    }
    
    return tempData
  }
}

struct AsyncMultiThreadScreen: View {
  @State var vm = AsyncMultiThreadScreenViewModel()
    var body: some View {
      VStack {
        Button("Fetch Data") {
          Task {
            await vm.fetchItems()
          }
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
