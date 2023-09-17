
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

// MARK: - Default Style

extension CodeStyle where Self == DefaultCodeStyle {
    public static var `default`: Self { Self() }
}

public struct DefaultCodeStyle: CodeStyle {

    public func makeBody(configuration: Configuration) -> some View {
        configuration.color { _ in
            .black
        } font: { _ in
            .system(size: 48, weight: .regular, design: .monospaced)
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
        fileprivate let base: AnyView
        public var body: some View { base }
    }

    fileprivate let tokens: [Token]

    public func color(
        _ color: (Token) -> Color,
        font: (Token) -> Font
    ) -> Code {
        let text = tokens.reduce(Text("")) { accumulated, token in
            let text: Text = Text(token.value)
                .font(font(token))
                .foregroundColor(color(token))
            return accumulated + text
        }

        return Code(base: AnyView(text))
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
