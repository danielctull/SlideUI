
import SwiftUI

private let presenterDisplayID = UUID().uuidString

/// A SwiftUI Scene that represents a slide presentation.
///
/// ```swift
/// @main
/// struct PresentationApp: App {
///   var body: some Scene {
///     Presentation {
///       Slide("Title") {
///         Text("Content")
///       }
///     }
///   }
/// }
/// ```
public struct Presentation<Slides: View>: Scene {

    @Environment(\.openWindow) private var openWindow
    @State private var deck = Deck()
    @State private var size = PresentationSize.zero
    private let slides: Slides

    /// Creates a presentation with the given slides.
    ///
    /// The `slides` view builder should provide a list of ``Slide`` values to
    /// be displayed in the presentation.
    ///
    /// ```swift
    /// Presentation {
    ///   Slide(header: "First title") {
    ///     Text("Content")
    ///   }
    ///   Slide(header: "What is a star?") {
    ///     Image(systemName: "star.fill")
    ///   }
    /// }
    /// ```
    ///
    /// - Warning: Any top-level view provided to `slides` that is not an
    ///            instance of ``Slide`` could possibly be rendered permanently
    ///            in the presentation. Therefore, it is advised that only
    ///            ``Slide`` instances are returned in this view builder.
    ///
    /// - Parameter slides: The slides to be presented.
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
