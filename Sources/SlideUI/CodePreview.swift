
import SwiftUI

@freestanding(expression)
public macro CodePreview<Content: View>(@ViewBuilder _ content: () -> Content) -> CodePreview<Content> = #externalMacro(module: "SlideUIMacros", type: "CodePreviewMacro")

public struct CodePreview<Content: View>: View {

    @Environment(\.codePreviewStyle) private var style
    private let code: LegacyCode
    private let content: Content

    public init(@ViewBuilder content: () -> Content, code: () -> LegacyCode) {
        self.code = code()
        self.content = content()
    }

    public var body: some View {
        let configuration = CodePreviewStyleConfiguration(
            code: code,
            content: content)
        AnyView(style.resolve(configuration: configuration))
    }
}

// MARK: - Horizontal Style

extension CodePreviewStyle where Self == HorizontalCodePreviewStyle {
    public static var horizontal: Self { Self() }
}

public struct HorizontalCodePreviewStyle: CodePreviewStyle {

    public func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.code
            configuration.content
        }
    }
}

// MARK: - Vertical Style

extension CodePreviewStyle where Self == VerticalCodePreviewStyle {
    public static var vertical: Self { Self() }
}

public struct VerticalCodePreviewStyle: CodePreviewStyle {

    public func makeBody(configuration: Configuration) -> some View {
        VStack {
            configuration.code
            configuration.content
        }
    }
}

// MARK: - Style

extension View {

    public func codePreviewStyle(_ style: some CodePreviewStyle) -> some View {
        environment(\.codePreviewStyle, style)
    }
}

public protocol CodePreviewStyle: DynamicProperty {

    typealias Configuration = CodePreviewStyleConfiguration
    associatedtype Body : View

    /// Creates a view that represents the body of a source view.
    ///
    /// The system calls this method for each ``CodeView`` instance in a
    /// view hierarchy where this style is the current source style.
    ///
    /// - Parameter configuration: The properties of the source view.
    @ViewBuilder func makeBody(configuration: Self.Configuration) -> Self.Body
}

private struct CodePreviewStyleKey: EnvironmentKey {
    static var defaultValue: any CodePreviewStyle = .horizontal
}

extension EnvironmentValues {

    fileprivate var codePreviewStyle: any CodePreviewStyle {
        get { self[CodePreviewStyleKey.self] }
        set { self[CodePreviewStyleKey.self] = newValue }
    }
}

public struct CodePreviewStyleConfiguration {

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

extension CodePreviewStyle {

    fileprivate func resolve(configuration: Configuration) -> some View {
        ResolvedCodePreviewStyle(style: self, configuration: configuration)
    }
}

private struct ResolvedCodePreviewStyle<Style: CodePreviewStyle>: View {

    let style: Style
    let configuration: Style.Configuration

    var body: some View {
        style.makeBody(configuration: configuration)
    }
}
