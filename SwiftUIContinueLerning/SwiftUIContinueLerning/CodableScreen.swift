//

import SwiftUI

struct CodableScreen: View {
  @State var vm = CodableScreenViewModel()
    var body: some View {
      Text("Hello, World!")
        .onAppear {
          vm.fetchFollowers()
        }
    }
}

@Observable
final class CodableScreenViewModel {
  var followers: [Follower] = []
  
  func fetchFollowers() {
    NetworkManager.shared.getFollowers(userName: "ankitgupta2oct", page: 1) {[weak self] followers, errorMessage in
      if let followers = followers {
        print(followers)
        self?.followers = followers
      }
    }
  }
}

#Preview {
    CodableScreen()
}
