import SwiftUI
import Analytics
import PokerHands
import ComposableArchitecture

public struct Counter: ReducerProtocol {
  public struct State: Equatable {
    var count = 0
  }
  public enum Action: Equatable {
    case incrementButtonTapped
    case decrementButtonTapped
    case resetButtonTapped
  }
  
  @Dependency(\.analytics.logEvent) var logEvent
  
  public var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case .incrementButtonTapped:
        state.count += 1
        return .run { _ in
          logEvent(("tap_count_increment", nil))
        }

      case .decrementButtonTapped:
        state.count -= 1
        return .run { _ in
          logEvent(("tap_count_decrement", nil))
        }

      case .resetButtonTapped:
        state.count = 0
        return .run { _ in
          logEvent(("tap_count_reset", nil))
        }
      }
    }
  }
}

struct CounterView: View {
  let store: StoreOf<Counter>
  
  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      ScrollView {
        VStack {
          Button {
            viewStore.send(.decrementButtonTapped)
          } label: {
            HStack {
              ForEach([Number.ten, .eleven, .twelve, .thirteen, .one], id: \.self) { number in
                TrumpView(trump: Trump(suit: .clubs, number: number))
              }
            }
          }
          .padding(.top, 24)
          
          Text(viewStore.count.description)
            .font(.largeTitle)
            .frame(height: 150)
          
          Button {
            viewStore.send(.incrementButtonTapped)
          } label: {
            HStack {
              ForEach([Number.two, .three, .four, .five, .six], id: \.self) { number in
                TrumpView(trump: Trump(suit: .diamonds, number: number))
              }
            }
          }
          
          Button("Reset") {
            viewStore.send(.resetButtonTapped)
          }
          .font(.callout)
          .foregroundColor(.blue)
          .frame(height: 26)
          .clipShape(Capsule())
          .padding(.top, 50)
        }
      }
      .navigationTitle("Counting")
    }
  }
}
