
import SwiftUI

public protocol Presentation: App {

    associatedtype Slides: View

    @ViewBuilder
    var slides: Slides { get }
}

extension Presentation {

    @SceneBuilder
    @MainActor
    public var body: some Scene {
        PresentationBody(slides: slides)
    }
}

private struct PresentationBody<Slides: View>: Scene {

    @State private var deck = Deck()
    let slides: Slides

    public var body: some Scene {
        WindowGroup {
            ZStack {
                slides
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
            .deck { deck = $0 }
            .environment(\.currentSlide, deck.current)
        }
    }
}
