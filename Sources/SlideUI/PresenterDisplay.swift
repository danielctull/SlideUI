
import SwiftUI

@Style
struct PresenterDisplay: View {

    @Environment(\.presenterDisplayStyle) private var style
    @Binding var deck: Deck

    public var body: some View {

        let configuration = PresenterDisplayStyleConfiguration(
            previousSlide: SlidePreview(slide: deck.previous),
            currentSlide: SlidePreview(slide: deck.current),
            nextSlide: SlidePreview(slide: deck.next),
            previousButton: Button("Previous") { deck.goPrevious() },
            nextButton: Button("Next") { deck.goNext() },
            notes: deck.current.notes)

        AnyView(style.resolve(configuration: configuration))
    }
}

// MARK: - SlidePreview

struct SlidePreview: View {

    @Environment(\.presentationSize) private var size
    let slide: SlideInfo?

    var body: some View {
        size.render {
            slide?.content()
        }
    }
}

// MARK: - Style

private struct DefaultPresenterDisplayStyle: PresenterDisplayStyle {

    func makeBody(configuration: Configuration) -> some View {
        VStack {
            HStack {
                configuration.preview.previous
                    .frame(width: 200, height: 150)
                configuration.preview.current
                    .frame(width: 400, height: 300)
                configuration.preview.next
                    .frame(width: 200, height: 150)
            }

            configuration.notes
            
            Spacer()

            HStack {
                configuration.control.previous
                configuration.control.next
            }
        }
        .padding()
    }
}

extension View {

    public func presenterDisplayStyle(_ style: some PresenterDisplayStyle) -> some View {
        environment(\.presenterDisplayStyle, style)
    }
}

extension Scene {

    public func presenterDisplayStyle(_ style: some PresenterDisplayStyle) -> some Scene {
        environment(\.presenterDisplayStyle, style)
    }
}

// MARK: Configuration

public struct PresenterDisplayStyleConfiguration {

    public struct Preview {

        public struct Previous: View {
            fileprivate let base: AnyView
            public var body: some View { base }
        }

        public struct Current: View {
            fileprivate let base: AnyView
            public var body: some View { base }
        }

        public struct Next: View {
            fileprivate let base: AnyView
            public var body: some View { base }
        }

        public let previous: Previous
        public let current: Current
        public let next: Next
    }

    public struct Control {
        
        public struct Previous: View {
            fileprivate let base: AnyView
            public var body: some View { base }
        }

        public struct Next: View {
            fileprivate let base: AnyView
            public var body: some View { base }
        }

        public let previous: Previous
        public let next: Next
    }

    public struct Notes: View {
        fileprivate let base: AnyView
        public var body: some View { base }
    }

    public let preview: Preview
    public let control: Control

    private let _notes: () -> Notes
    public var notes: Notes { _notes() }

    fileprivate init(
        previousSlide: some View,
        currentSlide: some View,
        nextSlide: some View,
        previousButton: some View,
        nextButton: some View,
        notes: @escaping () -> AnyView
    ) {
        self.preview = Preview(
            previous: Preview.Previous(base: AnyView(previousSlide)),
            current: Preview.Current(base: AnyView(currentSlide)),
            next: Preview.Next(base: AnyView(nextSlide)))
        self.control = Control(
            previous: Control.Previous(base: AnyView(previousButton)),
            next: Control.Next(base: AnyView(nextButton)))
        _notes = { Notes(base: notes()) }
    }
}

// MARK: Environment

private struct PresenterDisplayStyleKey: EnvironmentKey {
    static var defaultValue: any PresenterDisplayStyle = DefaultPresenterDisplayStyle()
}

extension EnvironmentValues {

    fileprivate var presenterDisplayStyle: any PresenterDisplayStyle {
        get { self[PresenterDisplayStyleKey.self] }
        set { self[PresenterDisplayStyleKey.self] = newValue }
    }
}

// MARK: Resolution

extension PresenterDisplayStyle {

    fileprivate func resolve(configuration: Configuration) -> some View {
        ResolvedPresenterDisplayStyle(style: self, configuration: configuration)
    }
}

private struct ResolvedPresenterDisplayStyle<Style: PresenterDisplayStyle>: View {

    let style: Style
    let configuration: Style.Configuration

    var body: some View {
        style.makeBody(configuration: configuration)
    }
}
