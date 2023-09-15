
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

private let presenterDisplayID = UUID().uuidString

private struct PresentationBody<Slides: View>: Scene {

    @Environment(\.openWindow) private var openWindow
    @State private var deck = Deck()
    let slides: Slides

    public var body: some Scene {
        
        WindowGroup("Presentation") {
            ZStack {
                slides
            }
            .deck { deck = $0 }
            .environment(\.currentSlide, deck.current)
            .onAppear { openWindow(id: presenterDisplayID) }
        }

        Window("Presenter Display", id: presenterDisplayID) {
            PresenterDisplay(deck: $deck)
        }
    }
}
