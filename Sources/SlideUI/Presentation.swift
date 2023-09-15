
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
                Color.white.opacity(0.0000001)
                    .onTapGesture { deck.previous() }
                Color.white.opacity(0.0000001)
                    .onTapGesture { deck.next() }
            }
        }
        .environment(\.currentSlide, deck.current)
        .deck { deck = $0 }
    }
}
