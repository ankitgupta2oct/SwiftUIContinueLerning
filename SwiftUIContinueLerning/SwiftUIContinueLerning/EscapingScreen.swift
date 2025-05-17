//

import SwiftUI

struct EscapingScreen: View {
  @State var vm = EscapingScreenViewModel()
  
    var body: some View {
      Text(vm.downloadData)
        .onAppear {
          vm.fetchData()
        }
    }
}

@Observable
final class EscapingScreenViewModel {
  var downloadData: String = ""
  
  func fetchData() {
//    download1()
//    
//    download2 { [weak self] data in
//      self?.downloadData = data
//    }
//    
//    download3 { [weak self] data in
//      self?.downloadData = data
//    }
//    
//    download4 { [weak self] model in
//      self?.downloadData = model.data
//    }
    
    download5 { [weak self] model in
      self?.downloadData = model.data
    }
  }
  
  func download1() {
    downloadData = "New Data1"
  }
  
  func download2(completion: @escaping (_ data: String) -> Void) {
    completion("New Data 2")
  }
  
  func download3(completion: @escaping (_ data: String) -> ()) {
    completion("New Data 3")
  }
  
  func download4(completion: @escaping (_ data: DataModel) -> ()) {
    completion(DataModel(data: "New Data 4"))
  }
  
  func download5(completion: @escaping DataResult) {
    completion(DataModel(data: "New Data 5"))
  }
}

typealias DataResult = (DataModel) -> Void

struct DataModel {
  let data: String
}

#Preview {
    EscapingScreen()
}
