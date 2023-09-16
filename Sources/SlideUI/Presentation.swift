
import SwiftUI

private let presenterDisplayID = UUID().uuidString

public struct Presentation<Slides: View>: Scene {

    @Environment(\.openWindow) private var openWindow
    @State private var deck = Deck()
    let slides: Slides

    public init(@ViewBuilder slides: () -> Slides) {
        self.slides = slides()
    }

    public var body: some Scene {
        
        WindowGroup("Presentation") {
            ZStack {
                slides
            }
            .deck { deck = $0 }
            .environment(\.currentSlide, deck.current.id)
            .onAppear { openWindow(id: presenterDisplayID) }
        }

        Window("Presenter Display", id: presenterDisplayID) {
            PresenterDisplay(deck: $deck)
        }
    }
}
