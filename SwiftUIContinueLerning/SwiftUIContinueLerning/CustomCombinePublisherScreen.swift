import SwiftUI
import Combine

struct CustomCombinePublisherScreen: View {
  @StateObject var vm = CustomCombinePublisherViweModel()
  
    var body: some View {
      VStack {
        VStack {
          Toggle("Submit", isOn: $vm.submitToggle)
          
          TextField("Enter the Value", text: $vm.userText)
            .padding()
            .background(.gray.opacity(0.2))
          
          Button("Submit") {
            
          }
          .buttonStyle(.borderedProminent)
          .disabled(vm.isSubmitDisable)
        }
        .padding()
      }
    }
}


final class CustomCombinePublisherViweModel: ObservableObject {
  @Published var submitToggle = false
  @Published var userText = ""
  @Published var isSubmitDisable = true
  
  var cancellable: Set<AnyCancellable> = []
  
  init() {
    $userText
      .combineLatest($submitToggle)
      .debounce(for: 0.5, scheduler: DispatchQueue.main)
      .map { (userText, submitToggle) in
        return userText.count > 3 && submitToggle
      }
      .sink {[weak self] canSubmit in
        self?.isSubmitDisable = !canSubmit
      }
      .store(in: &cancellable)
  }
}

#Preview {
    CustomCombinePublisherScreen()
}
