
import SwiftUI

@freestanding(expression)
public macro CodePreview<Content: View>(@ViewBuilder _ content: () -> Content) -> CodePreview<Content> = #externalMacro(module: "SlideUIMacros", type: "CodePreviewMacro")

public struct CodePreview<Content: View>: View {

    @Environment(\.codePreviewStyle) private var style
    private let code: Code
    private let content: Content

    public init(@ViewBuilder content: () -> Content, code: () -> Code) {
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
    static var horizontal: Self { Self() }
}

private struct HorizontalCodePreviewStyle: CodePreviewStyle {

    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.code
            configuration.content
        }
    }
}

// MARK: - Vertical Style

extension CodePreviewStyle where Self == VerticalCodePreviewStyle {
    static var vertical: Self { Self() }
}

private struct VerticalCodePreviewStyle: CodePreviewStyle {

    func makeBody(configuration: Configuration) -> some View {
        VStack {
            configuration.code
            configuration.content
        }
    }
}

// MARK: - Style

extension View {

    func codePreviewStyle(_ style: some CodePreviewStyle) -> some View {
        environment(\.codePreviewStyle, style)
    }
}

protocol CodePreviewStyle: DynamicProperty {

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

struct CodePreviewStyleConfiguration {

    /// A type-erased source view.
    struct Code: View {
        fileprivate init(_ view: some View) {
            base = AnyView(view)
        }
        private let base: AnyView
        var body: some View { base }
    }

    /// A type-erased content view.
    struct Content: View {
        fileprivate init(_ view: some View) {
            base = AnyView(view)
        }
        private let base: AnyView
        var body: some View { base }
    }

    let code: Code
    let content: Content

    fileprivate init(code: some View, content: some View) {
        self.code = Code(code)
        self.content = Content(content)
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
