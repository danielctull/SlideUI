
import SwiftUI

@freestanding(expression)
public macro Code<Content: View>(@ViewBuilder _ content: () -> Content) -> Code<Content> = #externalMacro(module: "SlideUIMacros", type: "CodeMacro")

public struct Code<Content: View>: View {

    @Environment(\.codeStyle) private var style
    private let code: LegacyCode
    private let content: Content

    public init(@ViewBuilder content: () -> Content, code: () -> LegacyCode) {
        self.code = code()
        self.content = content()
    }

    public var body: some View {
        let configuration = CodeStyleConfiguration(
            code: code,
            content: content)
        AnyView(style.resolve(configuration: configuration))
    }
}

// MARK: - Horizontal Style

extension CodeStyle where Self == HorizontalCodeStyle {
    public static var horizontal: Self { Self() }
}

public struct HorizontalCodeStyle: CodeStyle {

    public func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.code
            configuration.content
        }
    }
}

// MARK: - Vertical Style

extension CodeStyle where Self == VerticalCodeStyle {
    public static var vertical: Self { Self() }
}

public struct VerticalCodeStyle: CodeStyle {

    public func makeBody(configuration: Configuration) -> some View {
        VStack {
            configuration.code
            configuration.content
        }
    }
}

// MARK: - Style

extension View {

    public func codeStyle(_ style: some CodeStyle) -> some View {
        environment(\.codeStyle, style)
    }
}

public protocol CodeStyle: DynamicProperty {

    typealias Configuration = CodeStyleConfiguration
    associatedtype Body : View

    /// Creates a view that represents the body of a source view.
    ///
    /// The system calls this method for each ``CodeView`` instance in a
    /// view hierarchy where this style is the current source style.
    ///
    /// - Parameter configuration: The properties of the source view.
    @ViewBuilder func makeBody(configuration: Self.Configuration) -> Self.Body
}

private struct CodeStyleKey: EnvironmentKey {
    static var defaultValue: any CodeStyle = .horizontal
}

extension EnvironmentValues {

    fileprivate var codeStyle: any CodeStyle {
        get { self[CodeStyleKey.self] }
        set { self[CodeStyleKey.self] = newValue }
    }
}

public struct CodeStyleConfiguration {

    public struct Code: View {
        fileprivate let base: AnyView
        public var body: some View { base }
    }

    public struct Content: View {
        fileprivate let base: AnyView
        public var body: some View { base }
    }

    public let code: Code
    public let content: Content

    fileprivate init(code: some View, content: some View) {
        self.code = Code(base: AnyView(code))
        self.content = Content(base: AnyView(content))
    }
}

extension CodeStyle {

    fileprivate func resolve(configuration: Configuration) -> some View {
        ResolvedCodeStyle(style: self, configuration: configuration)
    }
}

private struct ResolvedCodeStyle<Style: CodeStyle>: View {

    let style: Style
    let configuration: Style.Configuration

    var body: some View {
        style.makeBody(configuration: configuration)
    }
}
