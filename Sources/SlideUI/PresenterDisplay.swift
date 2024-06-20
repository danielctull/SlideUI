
import SwiftUI

struct PresenterDisplay: View {

    @Environment(\.presenterDisplayStyle) private var style
    @Binding var deck: Deck

    public var body: some View {

        let configuration = PresenterDisplayStyleConfiguration(
            previous: deck.previous,
            current: deck.current,
            next: deck.next,
            showSlide: { info in deck.showSlide(info) })

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

    nonisolated init() {}

    func makeBody(configuration: Configuration) -> some View {
        VStack {
            HStack {
                configuration.slides.previous
                    .frame(width: 200, height: 150)
                configuration.slides.current
                    .frame(width: 400, height: 300)
                configuration.slides.next
                    .frame(width: 200, height: 150)
            }

            configuration.slides.current.notes
            
            Spacer()

            HStack {
                Button("Previous") { configuration.showSlide(configuration.slides.previous) }
                Button("Next") { configuration.showSlide(configuration.slides.next) }
            }
        }
        .padding()
    }
}

@MainActor
public protocol PresenterDisplayStyle: DynamicProperty {

    typealias Configuration = PresenterDisplayStyleConfiguration
    associatedtype Body: View

    @ViewBuilder @MainActor
    func makeBody(configuration: Configuration) -> Body
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

@MainActor
public struct PresenterDisplayStyleConfiguration {

    public struct Slides {
        public let previous: Slide
        public let current: Slide
        public let next: Slide
    }

    public struct Slide: View {
        fileprivate let info: SlideInfo?
        public var notes: Notes { Notes(content: info?.notes()) }
        public var body: some View { SlidePreview(slide: info) }
    }

    public struct Notes: View {
        fileprivate let content: AnyView?
        public var body: some View { content }
    }

    public let slides: Slides

    private let _showSlide: (SlideInfo?) -> ()
    public func showSlide(_ slide: Slide) {
        _showSlide(slide.info)
    }

    fileprivate init(
        previous: SlideInfo?,
        current: SlideInfo,
        next: SlideInfo?,
        showSlide: @escaping (SlideInfo?) -> ()
    ) {
        self.slides = Slides(
            previous: Slide(info: previous),
            current: Slide(info: current),
            next: Slide(info: next))
        self._showSlide = showSlide
    }
}

// MARK: Environment

private struct PresenterDisplayStyleKey: EnvironmentKey {
    static var defaultValue: any PresenterDisplayStyle { DefaultPresenterDisplayStyle() }
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
