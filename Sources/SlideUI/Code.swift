
import SwiftUI

@freestanding(expression)
public macro Code(_ code: () -> Any) -> Code = #externalMacro(module: "SlideUIMacros", type: "CodeMacro")

public struct Code: View {

    @Environment(\.codeStyle) private var style
    private let tokens: [Token]

    public init(_ code: () -> String) {
        tokens = Array(code: code())
    }

    public var body: some View {
        let configuration = CodeStyleConfiguration(tokens: tokens)
        AnyView(style.resolve(configuration: configuration))
    }
}

// MARK: - CodeStyle

extension CodeStyle where Self == DefaultCodeStyle {
    public static var `default`: Self { Self() }
}

public struct DefaultCodeStyle: CodeStyle {

    public func makeBody(configuration: Configuration) -> some View {
        configuration.code
    }
}

extension View {

    public func codeStyle(_ style: some CodeStyle) -> some View {
        environment(\.codeStyle, style)
    }
}

public protocol CodeStyle: DynamicProperty {

    typealias Configuration = CodeStyleConfiguration
    associatedtype Body : View

    /// Creates a view that represents the body of a code view.
    ///
    /// The system calls this method for each ``CodeView`` instance in a
    /// view hierarchy where this style is the current code style.
    ///
    /// - Parameter configuration: The properties of the code view.
    @ViewBuilder func makeBody(configuration: Self.Configuration) -> Self.Body
}

private struct CodeStyleKey: EnvironmentKey {
    static var defaultValue: any CodeStyle = DefaultCodeStyle()
}

extension EnvironmentValues {

    fileprivate var codeStyle: any CodeStyle {
        get { self[CodeStyleKey.self] }
        set { self[CodeStyleKey.self] = newValue }
    }
}

public struct CodeStyleConfiguration {

    public struct Code: View {

        @Environment(\.codeHighlighting) private var highlighting
        private let tokens: [Token]
        private let string: String

        fileprivate init(tokens: [Token]) {
            self.tokens = tokens
            self.string = tokens.map(\.value).reduce("", +)
        }

        public var body: some View {
            // Putting the coloring into overlay allows fast size calculations.
            Text(string)
                .hidden()
                .overlay {
                    tokens.map { token in
                        Text(token.value)
                            .foregroundColor(highlighting.color(for: token))
                    }
                    .reduce(Text(""), +)
                }
        }
    }

    public let code: Code

    fileprivate init(tokens: [Token]) {
        code = Code(tokens: tokens)
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

// MARK: - CodeHighlighting

extension View {

    public func codeHighlighting(_ style: some CodeHighlighting) -> some View {
        environment(\.codeHighlighting, style)
    }
}

extension Scene {

    public func codeHighlighting(_ style: some CodeHighlighting) -> some Scene {
        environment(\.codeHighlighting, style)
    }
}

public protocol CodeHighlighting: DynamicProperty {
    func color(for token: Token) -> Color
}

private struct CodeHighlightingKey: EnvironmentKey {
    static var defaultValue: any CodeHighlighting = DefaultCodeHighlighting()
}

private struct DefaultCodeHighlighting: CodeHighlighting {
    func color(for token: Token) -> Color { .black }
}

extension EnvironmentValues {

    fileprivate var codeHighlighting: any CodeHighlighting {
        get { self[CodeHighlightingKey.self] }
        set { self[CodeHighlightingKey.self] = newValue }
    }
}
