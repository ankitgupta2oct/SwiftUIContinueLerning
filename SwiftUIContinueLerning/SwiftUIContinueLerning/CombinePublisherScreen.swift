//

import SwiftUI

struct CombinePublisherScreen: View {
  
  // MARK: Current Date
  @State var currentDate = Date()
  let timerPublisher = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
  var dateFormetter: DateFormatter {
    let formetter = DateFormatter()
    formetter.timeStyle = .medium
    formetter.dateStyle = .medium
    return formetter
  }
  
  // MARK: Time Remaining
  let futureDate = Calendar.current.date(byAdding: .hour, value: 1, to: .now) ?? Date()
  @State var timeRemaining = ""
  
    var body: some View {
      VStack {
        Text("Current Date")
        Text(dateFormetter.string(from: currentDate))
          .font(.title3)
          .bold()
        
        Divider()
        Text("Time Remining")
        Text(timeRemaining)
          .font(.title3)
          .bold()
      }
      .onReceive(timerPublisher) { value in
        currentDate = value
      }
      .onReceive(timerPublisher) { _ in
        updateRemainingTime()
      }
    }
  
  func updateRemainingTime() {
    let dateComponents = Calendar.current.dateComponents([.minute, .second], from: .now, to: futureDate)
    let minute = dateComponents.minute ?? 0
    let seconds = dateComponents.second ?? 0
    timeRemaining = "\(minute):\(seconds)"
  }
}

#Preview {
    CombinePublisherScreen()
}
