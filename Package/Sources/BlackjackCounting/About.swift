import SwiftUI
import ComposableArchitecture

private enum Links {
  static let applicationReviewUrl = URL(string: "https://apps.apple.com/jp/app/id1544949227?mt=8&action=write-review")!
  static let developerTwitterUrl = URL(string: "https://twitter.com/tomokisun")!
  static let privacyPolicyUrl = URL(string: "https://tomokisun.github.io/BlackjackCounting/PrivacyPolicy")!
  static let openSourceSoftwareUrl = URL(string: "http://github.com/tomokisun/BlackjackCounting")!
}

public struct About: ReducerProtocol {
  public struct State: Equatable {}
  
  public enum Action: Equatable {
    case reviewButtonTapped
    case developerButtonTapped
    case privacyPolicyButtonTapped
    case ossButtonTapped
  }
  
  @Dependency(\.openURL) var openURL
  
  public var body: some ReducerProtocol<State, Action> {
    Reduce { _, action in
      switch action {
      case .reviewButtonTapped:
        return .run { _ in
          await openURL(Links.applicationReviewUrl)
        }
        
      case .developerButtonTapped:
        return .run { _ in
          await openURL(Links.developerTwitterUrl)
        }
        
      case .privacyPolicyButtonTapped:
        return .run { _ in
          await openURL(Links.privacyPolicyUrl)
        }
        
      case .ossButtonTapped:
        return .run { _ in
          await openURL(Links.openSourceSoftwareUrl)
        }
      }
    }
  }
}

struct AboutView: View {
  let store: StoreOf<About>
  
  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      List {
        Section {
          Button("Review the app") {
            viewStore.send(.reviewButtonTapped)
          }
          Button("Developer") {
            viewStore.send(.developerButtonTapped)
          }
          Button("Privacy Policy") {
            viewStore.send(.privacyPolicyButtonTapped)
          }
          Button("Open Source software") {
            viewStore.send(.ossButtonTapped)
          }
        }
      }
      .navigationTitle("About")
    }
  }
}
