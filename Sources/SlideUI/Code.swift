
import SwiftUI

@freestanding(expression)
public macro Code(_ source: () -> Any) -> Code = #externalMacro(module: "SlideUIMacros", type: "CodeMacro")

public struct Code: View {

    @Environment(\.sourceStyle) private var style
    private let source: String

    public init(source: String) {
        self.source = source
    }

    public var body: some View {
        let configuration = CodeStyleConfiguration(source: Text(source))
        AnyView(style.resolve(configuration: configuration))
    }
}

// MARK: - Default Style

private struct DefaultCodeStyle: CodeStyle {

    func makeBody(configuration: Configuration) -> some View {
        configuration.source
            .font(.system(size: 48, weight: .regular, design: .monospaced))
    }
}

// MARK: - Style

extension View {

    func sourceStyle(_ style: some CodeStyle) -> some View {
        environment(\.sourceStyle, style)
    }
}

protocol CodeStyle: DynamicProperty {

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
    static var defaultValue: any CodeStyle = DefaultCodeStyle()
}

extension EnvironmentValues {

    fileprivate var sourceStyle: any CodeStyle {
        get { self[CodeStyleKey.self] }
        set { self[CodeStyleKey.self] = newValue }
    }
}

struct CodeStyleConfiguration {

    /// A type-erased source view.
    struct Code: View {
        fileprivate init(_ view: some View) {
            base = AnyView(view)
        }
        private let base: AnyView
        var body: some View { base }
    }

    let source: Code

    fileprivate init(source: some View) {
        self.source = Code(source)
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
