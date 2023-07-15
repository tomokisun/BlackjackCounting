import SwiftUI
import ComposableArchitecture

public struct Root: ReducerProtocol {
  public init() {}
  public struct State: Equatable {
    var counter = Counter.State()
    var about = About.State()
    
    public init() {}
  }
  public enum Action: Equatable {
    case counter(Counter.Action)
    case about(About.Action)
  }
  
  public var body: some ReducerProtocol<State, Action> {
    Scope(state: \.counter, action: /Action.counter) {
      Counter()
    }
    Scope(state: \.about, action: /Action.about) {
      About()
    }
  }
}

public struct RootView: View {
  var store: StoreOf<Root>
  
  public init(store: StoreOf<Root>) {
    self.store = store
  }
  
  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      CounterView(store: store.scope(state: \.counter, action: Root.Action.counter))
        .toolbar {
          NavigationLink(
            destination: AboutView(
              store: store.scope(
                state: \.about,
                action: Root.Action.about
              )
            ),
            label: {
              Image(systemName: "person.crop.circle")
                .font(.title)
            }
          )
        }
    }
  }
}
