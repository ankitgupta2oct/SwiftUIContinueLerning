//
//  MultipleSheetScreen.swift
//  SwiftUIContinueLerning
//
//  Created by z0042k3y on 14/05/25.
//

import SwiftUI

struct MultipleSheetScreen: View {
  @State var sheetModel: SheetModel?
  
    var body: some View {
      VStack {
        Button("Show Sheet 1") {
          sheetModel = SheetModel(title: "Title 1")
        }
        Button("Show Sheet 2") {
          sheetModel = SheetModel(title: "Title 2")
        }
      }
      .sheet(item: $sheetModel) { model in
        SheetView(model: model)
      }
    }
}

struct SheetView: View {
  let model: SheetModel
  
  init(model: SheetModel) {
    self.model = model
    print("SheetView init")
  }
  
  var body: some View {
    Text(model.title)
  }
}

struct SheetModel: Identifiable {
  var id = UUID().uuidString
  let title: String
}

#Preview {
    MultipleSheetScreen()
}
