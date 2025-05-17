//

import SwiftUI
import Combine

struct CombineScreen: View {
  @State var vm = CombineScreenViewModel()
  
    var body: some View {
      List {
        ForEach(vm.followers, id: \.self) { follower in
          Text(follower.loginId)
            .font(.title)
        }
      }
      .onAppear {
        vm.fetchFollowers()
      }
    }
}

@Observable
final class CombineScreenViewModel {
  var followers: [Follower] = []
  var cancellableCollection: Set<AnyCancellable> = []
  
  func fetchFollowers() {
    try? NetworkManager.shared.getFollowersWithCombine(userName: "ankitgupta2oct", page: 1, cancellableCollection: &cancellableCollection) {[weak self] followers, error in
      if let followers = followers {
        self?.followers = followers
      }
    }
  }
}

#Preview {
    CombineScreen()
}
