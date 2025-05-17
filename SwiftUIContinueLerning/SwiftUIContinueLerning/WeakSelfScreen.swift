import SwiftUI

struct WeakSelfScreen: View {
  @AppStorage("Count") var count: Int?

    var body: some View {
      NavigationStack {
        NavigationLink("Next") {
          WeakSelfSecondScreen()
        }
      }
    }
}

struct WeakSelfSecondScreen: View {
  @StateObject var vm = WeakSelfSecondViewModel()
  
  var body: some View {
    Text("Count \(vm.count)")
    Text(vm.data)
  }
}

final class WeakSelfSecondViewModel: ObservableObject {
  @Published var count: Int = 0
  @Published var data = "No Data"
  
  init() {
    print("Init called")
    count = UserDefaults.standard.integer(forKey: "Count")
    count += 1
    UserDefaults.standard.set(count, forKey: "Count")
    
    fetchData()
  }
  
  deinit {
    print("Deinit called")
    count = UserDefaults.standard.integer(forKey: "Count")
    count -= 1
    UserDefaults.standard.set(count, forKey: "Count")
  }
  
  func fetchData() {
    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(10)) { [weak self] in
      self?.data = "New Data"
    }
  }
}

#Preview {
    WeakSelfScreen()
}
