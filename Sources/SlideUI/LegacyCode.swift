
import SwiftUI

@freestanding(expression)
public macro LegacyCode(_ code: () -> Any) -> LegacyCode = #externalMacro(module: "SlideUIMacros", type: "LegacyCodeMacro")

public struct LegacyCode: View {

    @Environment(\.legacyCodeStyle) private var style
    private let tokens: [Token]

    public init(_ code: () -> String) {
        tokens = Array(code: code())
    }

    public var body: some View {
        let configuration = LegacyCodeStyleConfiguration(tokens: tokens)
        AnyView(style.resolve(configuration: configuration))
    }
}

// MARK: - LegacyCodeStyle

extension LegacyCodeStyle where Self == DefaultLegacyCodeStyle {
    public static var `default`: Self { Self() }
}

public struct DefaultLegacyCodeStyle: LegacyCodeStyle {

    public func makeBody(configuration: Configuration) -> some View {
        configuration.code
    }
}

extension View {

    public func legacyCodeStyle(_ style: some LegacyCodeStyle) -> some View {
        environment(\.legacyCodeStyle, style)
    }
}

public protocol LegacyCodeStyle: DynamicProperty {

    typealias Configuration = LegacyCodeStyleConfiguration
    associatedtype Body : View

    /// Creates a view that represents the body of a code view.
    ///
    /// The system calls this method for each ``CodeView`` instance in a
    /// view hierarchy where this style is the current code style.
    ///
    /// - Parameter configuration: The properties of the code view.
    @ViewBuilder func makeBody(configuration: Self.Configuration) -> Self.Body
}

private struct LegacyCodeStyleKey: EnvironmentKey {
    static var defaultValue: any LegacyCodeStyle = DefaultLegacyCodeStyle()
}

extension EnvironmentValues {

    fileprivate var legacyCodeStyle: any LegacyCodeStyle {
        get { self[LegacyCodeStyleKey.self] }
        set { self[LegacyCodeStyleKey.self] = newValue }
    }
}

public struct LegacyCodeStyleConfiguration {

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

extension LegacyCodeStyle {

    fileprivate func resolve(configuration: Configuration) -> some View {
        ResolvedLegacyCodeStyle(style: self, configuration: configuration)
    }
}

private struct ResolvedLegacyCodeStyle<Style: LegacyCodeStyle>: View {

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
