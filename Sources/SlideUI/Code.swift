
import SwiftUI

@freestanding(expression)
public macro Code(_ code: () -> Any) -> Code = #externalMacro(module: "SlideUIMacros", type: "CodeMacro")

public struct Code: View {

    @Environment(\.codeStyle) private var style
    private let code: String

    public init(_ code: String) {
        self.code = code
    }

    public var body: some View {
        let configuration = CodeStyleConfiguration(code: Text(code))
        AnyView(style.resolve(configuration: configuration))
    }
}

// MARK: - Default Style

extension CodeStyle where Self == DefaultCodeStyle {
    public static var `default`: Self { Self() }
}

public struct DefaultCodeStyle: CodeStyle {

    public func makeBody(configuration: Configuration) -> some View {
        configuration.code
            .font(.system(size: 48, weight: .regular, design: .monospaced))
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

    public let code: Code

    fileprivate init(code: some View) {
        self.code = Code(base: AnyView(code))
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
