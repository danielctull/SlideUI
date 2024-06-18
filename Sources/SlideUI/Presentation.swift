
import SwiftUI

private let presenterDisplayID = UUID().uuidString

public struct Presentation<Slides: View>: Scene {

    @Environment(\.openWindow) private var openWindow
    @State private var deck = Deck()
    @State private var size = PresentationSize.zero
    private let slides: Slides

    public init(@ViewBuilder slides: () -> Slides) {
        self.slides = slides()
    }

    public var body: some Scene {
        
        WindowGroup("Presentation") {
            ZStack {
                slides
            }
            .environment(\.currentSlide, deck.current.id)
            .environment(\.presentationSize, size)
            .onAppear { openWindow(id: presenterDisplayID) }
            .onDeckChange { deck = $0 }
            .onPresentationSizeChange { size = $0 }
        }

        Window("Presenter Display", id: presenterDisplayID) {
            PresenterDisplay(deck: $deck)
                .environment(\.presentationSize, size)
        }
    }
}
