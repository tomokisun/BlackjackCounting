import SwiftUI
import StoreKit
import Analytics
import ComposableArchitecture

public struct Root: ReducerProtocol {
  public init() {}
  public struct State: Equatable {
    var counter = Counter.State()
    
    public init() {}
  }
  public enum Action: Equatable {
    case counter(Counter.Action)
    case onTask
  }
  
  @Dependency(\.analytics.setAnalyticsCollectionEnabled) var setAnalyticsCollectionEnabled
  
  public var body: some ReducerProtocol<State, Action> {
    Scope(state: \.counter, action: /Action.counter) {
      Counter()
    }
    Reduce { _, action in
      switch action {
      case .counter:
        return .none
        
      case .onTask:
        return .run { _ in
          #if DEBUG
            setAnalyticsCollectionEnabled(false)
          #else
            setAnalyticsCollectionEnabled(true)
          #endif
        }
      }
    }
  }
}

public struct RootView: View {
  var store: StoreOf<Root>
  @Environment(\.requestReview) var requestReview
  
  public init(store: StoreOf<Root>) {
    self.store = store
  }
  
  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      CounterView(store: store.scope(state: \.counter, action: Root.Action.counter))
        .task {
          await viewStore.send(.onTask).finish()
          requestReview()
        }
    }
  }
}
