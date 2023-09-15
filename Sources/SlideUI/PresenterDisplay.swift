
import SwiftUI

struct PresenterDisplay: View {

    @Environment(\.presenterDisplayStyle) private var style
    @Binding var deck: Deck

    public var body: some View {

        let configuration = PresenterDisplayConfiguration(
            previousSlide: EmptyView(),
            currentSlide: EmptyView(),
            nextSlide: EmptyView(),
            previousButton: Button("Previous") { deck.previous() },
            nextButton: Button("Next") { deck.next() },
            notes: Text("Some notes"))

        AnyView(style.resolve(configuration: configuration))
    }
}

// MARK: - Plain Style

extension PresenterDisplayStyle where Self == DefaultPresenterDisplayStyle {

    public static var `default`: Self { DefaultPresenterDisplayStyle() }
}

public struct DefaultPresenterDisplayStyle: PresenterDisplayStyle {

    public func makeBody(configuration: Configuration) -> some View {
        VStack {
            HStack {
                configuration.preview.previous
                configuration.preview.current
                configuration.preview.next
            }

            configuration.notes

            HStack {
                configuration.control.previous
                configuration.control.next
            }
        }
    }
}

// MARK: - Style

public protocol PresenterDisplayStyle: DynamicProperty {

    typealias Configuration = PresenterDisplayConfiguration
    associatedtype Body: View

    @ViewBuilder func makeBody(configuration: Configuration) -> Body
}

extension View {

    public func presenterDisplayStyle(_ style: some PresenterDisplayStyle) -> some View {
        environment(\.presenterDisplayStyle, style)
    }
}

// MARK: Configuration

public struct PresenterDisplayConfiguration {

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
    public let notes: Notes

    fileprivate init(
        previousSlide: some View,
        currentSlide: some View,
        nextSlide: some View,
        previousButton: some View,
        nextButton: some View,
        notes: some View
    ) {
        self.preview = Preview(
            previous: Preview.Previous(base: AnyView(previousSlide)),
            current: Preview.Current(base: AnyView(currentSlide)),
            next: Preview.Next(base: AnyView(nextSlide)))
        self.control = Control(
            previous: Control.Previous(base: AnyView(previousButton)),
            next: Control.Next(base: AnyView(nextButton)))
        self.notes = Notes(base: AnyView(notes))
    }
}

// MARK: Environment

private struct PresenterDisplayStyleKey: EnvironmentKey {
    static var defaultValue: any PresenterDisplayStyle = .default
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
