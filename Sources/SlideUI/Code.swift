
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

        @Environment(\.tokenStyle) private var style
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
                            .foregroundColor(style.color(for: token))
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

// MARK: - TokenStyle

extension TokenStyle where Self == DefaultTokenStyle {
    public static var `default`: Self { Self() }
}

public struct DefaultTokenStyle: TokenStyle {

    public func color(for token: Token) -> Color {
        .black
    }
}

extension View {

    public func tokenStyle(_ style: some TokenStyle) -> some View {
        environment(\.tokenStyle, style)
    }
}

public protocol TokenStyle: DynamicProperty {
    func color(for token: Token) -> Color
}

private struct TokenStyleKey: EnvironmentKey {
    static var defaultValue: any TokenStyle = DefaultTokenStyle()
}

extension EnvironmentValues {

    fileprivate var tokenStyle: any TokenStyle {
        get { self[TokenStyleKey.self] }
        set { self[TokenStyleKey.self] = newValue }
    }
}
