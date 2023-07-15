import SwiftUI
import BlackjackCounting
import ComposableArchitecture

@main
struct MultiplatformApp: App {
  var body: some Scene {
    WindowGroup {
      NavigationStack {
        RootView(
          store: .init(
            initialState: Root.State(),
            reducer: Root()._printChanges()
          )
        )
      }
    }
  }
}
