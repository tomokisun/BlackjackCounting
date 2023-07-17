import SwiftUI
import FirebaseCore
import BlackjackCounting
import ComposableArchitecture

final class AppDelegate: NSObject, UIApplicationDelegate {
  let store = Store(
    initialState: Root.State(),
    reducer: Root()._printChanges()
  )
  
  var viewStore: ViewStore<Void, Root.Action> {
    return ViewStore(store.stateless)
  }
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
  ) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct MultiplatformApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
  
  var body: some Scene {
    WindowGroup {
      NavigationStack {
        RootView(store: appDelegate.store)
      }
    }
  }
}
