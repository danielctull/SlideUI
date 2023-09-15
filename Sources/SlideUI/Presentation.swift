
import SwiftUI

public struct Presentation<Content: View>: View {

    @State private var deck = Deck()
    private let content: () -> Content

    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    public var body: some View {
        ZStack {
            content()
        }
        .overlay {
            HStack(spacing: 0) {
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture { deck.previous() }
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture { deck.next() }
            }
        }
        .environment(\.currentSlide, deck.current)
        .deck { deck = $0 }
    }
}
