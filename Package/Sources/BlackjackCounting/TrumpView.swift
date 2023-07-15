import SwiftUI
import PokerHands

struct TrumpView: View {
  let trump: Trump
  
  var foregroundColor: Color {
      switch trump.suit {
      case .hearts, .diamonds:
          return Color(.systemRed)
      case .clubs, .spades:
          return Color.primary
      }
  }
  
  var body: some View {
    VStack {
      Text(trump.number.string)
        .foregroundColor(foregroundColor)
        .font(.title)
      
      Text(trump.suit.string)
        .foregroundColor(foregroundColor)
        .font(.title)
    }
    .padding(.vertical, 10)
    .padding(.horizontal, 15)
    .background(Color(.systemGray6))
    .cornerRadius(9)
  }
}
