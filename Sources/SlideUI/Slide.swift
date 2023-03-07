
import SwiftUI

public struct Slide<Content: View>: View {

    @Environment(\.slideStyle) private var style
    private let content: Content

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    public var body: some View {
        let configuration = SlideConfiguration(content: content)
        AnyView(style.resolve(configuration: configuration))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - Plain Style

extension SlideStyle where Self == PlainSlideStyle {

    public static var plain: Self { PlainSlideStyle() }
}

public struct PlainSlideStyle: SlideStyle {

    public func makeBody(configuration: Configuration) -> some View {
        VStack {
            configuration.content
        }
    }
}

// MARK: - Style

public protocol SlideStyle: DynamicProperty {

    typealias Configuration = SlideConfiguration
    associatedtype Body: View

    @ViewBuilder func makeBody(configuration: Configuration) -> Body
}

extension View {

    public func slideStyle(_ style: some SlideStyle) -> some View {
        environment(\.slideStyle, style)
    }
}

// MARK: Configuration

public struct SlideConfiguration {

    public struct Content: View {
        fileprivate let base: AnyView
        public var body: some View { base }
    }

    public let content: Content

    fileprivate init(content: some View) {
        self.content = Content(base: AnyView(content))
    }
}

// MARK: Environment

private struct SlideStyleKey: EnvironmentKey {
    static var defaultValue: any SlideStyle = .plain
}

extension EnvironmentValues {

    fileprivate var slideStyle: any SlideStyle {
        get { self[SlideStyleKey.self] }
        set { self[SlideStyleKey.self] = newValue }
    }
}

// MARK: Resolution

extension SlideStyle {

    fileprivate func resolve(configuration: Configuration) -> some View {
        ResolvedSlideStyle(style: self, configuration: configuration)
    }
}

private struct ResolvedSlideStyle<Style: SlideStyle>: View {

    let style: Style
    let configuration: Style.Configuration

    var body: some View {
        style.makeBody(configuration: configuration)
    }
}
